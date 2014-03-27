# This file is part of KalibroGatekeeperClient
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
require 'kalibro_gatekeeper_client/helpers/hash_converters'
require 'kalibro_gatekeeper_client/helpers/request_methods'

module KalibroGatekeeperClient
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

      def self.request(action, params = {}, method = :post)
        client.send(method, "/#{endpoint}/#{action}", params).body
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
          response = self.class.request(save_action, save_params)
          self.id = response["id"]
          self.kalibro_errors = response["kalibro_errors"]

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
        request(exists_action, id_params(id))['exists']
      end

      def self.find(id)
        if(exists?(id))
          new request(find_action, id_params(id))
        else
          raise KalibroGatekeeperClient::Errors::RecordNotFound
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
        create_array_from_hash(response).map { |hash| new hash }
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

      # TODO: probably the connection could be a class static variable.
      def self.client
        Faraday.new(:url => KalibroGatekeeperClient.config[:address]) do |conn|
          conn.request :json
          conn.response :json, :content_type => /\bjson$/
          conn.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        end
      end

      def self.is_valid?(field)
        field.to_s[0] != '@' and field != :attributes! and (field =~ /attributes!/).nil? and (field.to_s =~ /xsi/).nil?  and (field.to_s =~ /errors/).nil?
      end

      # TODO: Rename to entitie_name
      def instance_class_name
        self.class.class_name
      end

      include RequestMethods
      extend RequestMethods::ClassMethods

      def add_error(exception)
        @kalibro_errors << exception
      end

      def self.endpoint
        class_name.pluralize.underscore
      end

      # TODO: Rename to entitie_name
      def self.class_name
        # This loop is a generic way to make this work even when the children class has a different name
        entitie_class = self
        until entitie_class.name.include?("KalibroGatekeeperClient::Entities::") do
          entitie_class = entitie_class.superclass
        end

        entitie_class.name.gsub(/KalibroGatekeeperClient::Entities::/,"")
      end

      include HashConverters
    end
  end
end