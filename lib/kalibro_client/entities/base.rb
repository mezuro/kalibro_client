# This file is part of KalibroClient
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

require 'faraday_middleware'
require 'kalibro_client/helpers/hash_converters'
require 'kalibro_client/helpers/request_methods'

module KalibroClient
  module Entities
    class Base
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

      def self.request(action, params = {}, method = :post, prefix="")
        response = client.send(method) do |request|
          url = "/#{endpoint}/#{action}".gsub(":id", params[:id].to_s)
          url = "/#{prefix}#{url}" unless prefix.empty?
          request.url url
          request.body = params unless params.empty?
          request.options.timeout = 300
          request.options.open_timeout = 300
        end

        response.body
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
          response = self.class.request(save_action, save_params, :post, save_prefix)
          self.id = response[instance_class_name]["id"]
          self.kalibro_errors = response["kalibro_errors"] unless response["kalibro_errors"].nil?
          self.created_at = response[instance_class_name]["created_at"] unless response[instance_class_name]["created_at"].nil?
          self.updated_at = response[instance_class_name]["updated_at"] unless response[instance_class_name]["updated_at"].nil?

          self.kalibro_errors.empty? ? true : false
        rescue Exception => exception
          add_error exception
          false
        end
      end

      def save!
        save
      end

      def self.create(attributes={})
        new_model = new attributes
        new_model.save
        new_model
      end

      def ==(another)
        unless self.class == another.class
          return false
        end

        self.variable_names.each do |name|
          next if name == "created_at" or name == "updated_at"
          unless self.send("#{name}") == another.send("#{name}") then
            return false
          end
        end

        return true
      end

      def self.exists?(id)
        request(exists_action, id_params(id), :get)['exists']
      end

      def self.find(id)
        if(exists?(id))
          response = request(find_action, id_params(id), :get)
          new response[entity_name]
        else
          raise KalibroClient::Errors::RecordNotFound
        end
      end

      def destroy
        begin
          self.class.request(destroy_action, destroy_params, :delete)
        rescue Exception => exception
          add_error exception
        end
      end

      def self.create_objects_array_from_hash (response)
        create_array_from_hash(response[entity_name.pluralize]).map { |hash| new hash }
      end

      def self.create_array_from_hash (response)
        response = [] if response.nil?
        response = [response] if response.is_a?(Hash)
        response
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

      def self.address
        raise NotImplementedError
      end

      # TODO: probably the connection could be a class static variable.
      def self.client
        Faraday.new(:url => KalibroClient.config[address]) do |conn|
          conn.request :json
          conn.response :json, :content_type => /\bjson$/
          conn.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        end
      end

      def self.is_valid?(field)
        field.to_s[0] != '@' and field != :attributes! and (field =~ /attributes!/).nil? and (field.to_s =~ /xsi/).nil?  and (field.to_s =~ /errors/).nil?
      end

      # TODO rename to instance_entity_name
      def instance_class_name
        self.class.entity_name
      end

      include RequestMethods
      extend RequestMethods::ClassMethods

      def add_error(exception)
        @kalibro_errors << exception
      end

      def self.endpoint
        entity_name.pluralize
      end

      def self.entity_name
        # This loop is a generic way to make this work even when the children class has a different name
        entity_class = self
        until entity_class.name.include?("KalibroClient::Entities::") do
          entity_class = entity_class.superclass
        end

        return entity_class.name.split("::").last.underscore.downcase
      end

      include HashConverters
    end
  end
end
