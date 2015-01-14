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

module KalibroClient
  module Entities
    module Processor
      class Repository < KalibroClient::Entities::Processor::Base

        attr_accessor :id, :name, :description, :license, :process_period, :type, :address, :configuration_id, :project_id, :send_email

        def self.repository_types
          request('types', {}, :get)['types'].to_a
        end

        def self.repositories_of(project_id)
          create_objects_array_from_hash request('of', {project_id: project_id}, :get)
        end

        def id=(value)
          @id = value.to_i
        end

        def process_period=(value)
          @process_period = value.to_i
        end

        def configuration_id=(value)
          @configuration_id = value.to_i
        end

        def project_id=(value)
          @project_id = value.to_i
        end

        def process
          self.class.request('process', {id: self.id})
        end

        def cancel_processing_of_repository
          self.class.request('cancel_process', {id: self.id})
        end

        def self.all
          projects = Project.all
          repositories = []

          projects.each do |project|
            repositories.concat(repositories_of(project.id))
          end

          return repositories
        end

        private

        def save_params
          {repository: self.to_hash, project_id: project_id}
        end
      end
    end
  end
end
