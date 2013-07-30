# This file is part of KalibroEntities
# Copyright (C) 2013  it's respectives authors (please see the AUTHORS file)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'savon'

class String
  def underscore(camel_cased_word = self)
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end
end

module KalibroEntities
  class Model

    attr_accessor :errors

    def initialize(attributes={})
      attributes.each { |field, value| send("#{field}=", value) if self.class.is_valid?(field) }
      @errors = []
    end


    def to_hash(options={})
      hash = Hash.new
      excepts = options[:except].nil? ? [] : options[:except]
      excepts << :errors
      fields.each do |field|
        hash = field_to_hash(field).merge(hash) if !excepts.include?(field)
      end
      hash
    end

    def self.request(action, request_body = nil)
      response = client(endpoint).call(action, message: request_body )
      response.to_hash["#{action}_response".to_sym] # response is a Savon::SOAP::Response, and to_hash is a Savon::SOAP::Response method
    end

    def self.to_object value
      value.kind_of?(Hash) ? new(value) : value
    end

    def self.to_objects_array value
      array = value.kind_of?(Array) ? value : [value]
      array.each.map { |element| to_object(element) }
    end

    def save
      begin
        self.id = self.class.request(save_action, save_params)["#{instance_class_name.underscore}_id".to_sym]
        true
      rescue Exception => exception
        add_error exception
        false
      end
    end

    def self.create(attributes={})
      new_model = new attributes
      new_model.save
      new_model
    end

    def ==(another)
      unless self.class == another.class then
        return false
      end
      self.variable_names.each {
        |name|
        unless self.send("#{name}") == another.send("#{name}") then
          return false
        end
      }
      true
    end

    def self.exists?(id)
      request(exists_action, id_params(id))[:exists]
    end

    def self.find(id)
      if(exists?(id))
        new request(find_action, id_params(id))["#{class_name.underscore}".to_sym]
      else
        raise KalibroEntities::Errors::RecordNotFound
      end
    end

    def destroy
      begin
        self.class.request(destroy_action, destroy_params)
      rescue Exception => exception
        add_error exception
      end
    end

    def self.create_objects_array_from_hash (response)
      response = [] if response.nil?
      response = [response] if response.is_a?(Hash)
      response.map { |hash| new hash }
    end

    protected

    def instance_variable_names
      instance_variables.map { |var| var.to_s }
    end

    def fields
      instance_variable_names.each.collect { |variable| variable.to_s.sub(/@/, '').to_sym }
    end

    def variable_names
      instance_variable_names.each.collect { |variable| variable.to_s.sub(/@/, '') }
    end

    def self.client(endpoint)
      Savon.client(wsdl: "#{KalibroEntities.config[:address]}#{endpoint}Endpoint/?wsdl")
    end

    def self.is_valid?(field)
      field.to_s[0] != '@' and field != :attributes! and (field.to_s =~ /xsi/).nil?
    end

    def instance_class_name
      self.class.name.gsub(/KalibroEntities::/,"")
    end

    def save_params
      {instance_class_name.underscore.to_sym => self.to_hash}
    end

    def save_action
      "save_#{instance_class_name.underscore}".to_sym
    end

    def destroy_action
      "delete_#{instance_class_name.underscore}".to_sym
    end

    def destroy_params
      {"#{instance_class_name.underscore}_id".to_sym => self.id}
    end

    def self.exists_action
      "#{class_name.underscore}_exists".to_sym
    end

    def self.id_params(id)
      {"#{class_name.underscore}_id".to_sym => id}
    end

    def self.find_action
      "get_#{class_name.underscore}".to_sym
    end

    def add_error(exception)
      @errors << exception
    end

    def self.endpoint
      class_name
    end

    def self.class_name
      self.name.gsub(/KalibroEntities::/,"")
    end

    def self.date_with_milliseconds(date)
      milliseconds = "." + (date.sec_fraction * 60 * 60 * 24 * 1000).to_s
      date.to_s[0..18] + milliseconds + date.to_s[19..-1]
    end

    def convert_to_hash(value)
      return value if value.nil?
      return value.collect { |element| convert_to_hash(element) } if value.is_a?(Array)
      return value.to_hash if value.is_a?(Kalibro::Model)
      return self.class.date_with_milliseconds(value) if value.is_a?(DateTime)
      return 'INF' if value.is_a?(Float) and value.infinite? == 1
      return '-INF' if value.is_a?(Float) and value.infinite? == -1
      value.to_s
    end

    def field_to_hash(field)
      hash = Hash.new
      field_value = send(field)
      if !field_value.nil?
        hash[field] = convert_to_hash(field_value)
        hash = get_xml(field, field_value).merge(hash)
      end
      hash
    end
  end

end