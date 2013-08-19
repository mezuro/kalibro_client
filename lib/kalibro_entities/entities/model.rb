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
require 'kalibro_entities/helpers/hash_converters'
require 'kalibro_entities/helpers/request_methods'

module KalibroEntities
  module Entities
    class Model
      attr_accessor :kalibro_errors

      def initialize(attributes={})
        attributes.each { |field, value| send("#{field}=", value) if self.class.is_valid?(field) }
        @kalibro_errors = []
      end

      def to_hash(options={})
        hash = Hash.new
        excepts = options[:except].nil? ? [] : options[:except]
        excepts << :kalibro_errors
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
        self.class.name.gsub(/KalibroEntities::Entities::/,"")
      end

      include RequestMethods
      extend RequestMethods::ClassMethods

      def add_error(exception)
        @kalibro_errors << exception
      end

      def self.endpoint
        class_name
      end

      def self.class_name
        self.name.gsub(/KalibroEntities::Entities::/,"")
      end

      include HashConverters
    end
  end
end