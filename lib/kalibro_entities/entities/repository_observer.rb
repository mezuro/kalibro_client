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
    class RepositoryObserver < Model
      attr_accessor :id, :repository_id, :name, :email

      def id=(value)
        @id = value.to_i
      end

      def repository_id=(value)
        @repository_id = value.to_i
      end

      def name=(value)
        @name = value
      end

      def email=(value)
        @email = value
      end

      # FIXME: the index of the second parameter of the request must be repository_id. It can't be fixed here until Kalibro webservice remain with this name!
      def self.repository_observers_of(value)
        create_objects_array_from_hash request(:repository_observers_of, {:repository_observer_id => value})[:repository_observer]
      end

      def self.all
        create_objects_array_from_hash request(:all_repository_observers)[:repository_observer]
      end
    end
  end
end