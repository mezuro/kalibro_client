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

require "kalibro_entities/entities/model"

module KalibroEntities
  module Entities
    class ModuleResult < Model

      attr_accessor :id, :module, :grade, :parent_id, :height
      
      def self.find(id)
        begin
          new request(:get_module_result, { :module_result_id => id })[:module_result]
        rescue
          raise KalibroEntities::Errors::RecordNotFound
        end
      end

      def children
        response = self.class.request(:children_of, {:module_result_id => id})[:module_result]
        response = [] if response.nil?
        response = [response] if response.is_a?(Hash)
        response.map {|module_result| KalibroEntities::Entities::ModuleResult.new module_result}
      end
      
      def parents
        if parent_id == 0
          []
        else
          parent = self.class.find(parent_id)
          parent.parents << parent
        end
      end

      def id=(value)
        @id = value.to_i
      end

      def module=(value)
        @module = KalibroEntities::Entities::Module.to_object value
      end

      def grade=(value)
        @grade = value.to_f
      end

      def parent_id=(value)
        @parent_id = value.to_i
      end

      def self.history_of(module_result_id)
        response = self.request(:history_of_module, {:module_result_id => module_result_id})[:date_module_result]
        response = [] if response.nil?
        response = [response] if response.is_a?(Hash)
        response.map {|date_module_result| KalibroEntities::Entities::DateModuleResult.new date_module_result}
      end
    end
  end
end