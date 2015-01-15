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
      class Processing < KalibroClient::Entities::Processor::Base

        attr_accessor :id, :date, :state, :error, :process_time, :root_module_result_id, :error_message, :repository_id

        def id=(value)
          @id = value.to_i
        end

        def repository_id=(value)
          @repository_id = value.to_i
        end

        def date=(value)
          @date = value.is_a?(String) ? DateTime.parse(value) : value
        end

        def process_times=(value)
          @process_time = value
        end

        def process_time=(value)
          @process_time = KalibroClient::Entities::Processor::ProcessTime.to_objects_array value
        end

        def process_times
          @process_time
        end

        def root_module_result_id=(value)
          @root_module_result_id = value.to_i
        end

        def self.processing_of(repository_id)
          if has_ready_processing(repository_id)
            last_ready_processing_of(repository_id)
          else
            last_processing_of(repository_id)
          end
        end

        def self.processing_with_date_of(repository_id, date)
          date = date.is_a?(String) ? DateTime.parse(date) : date
          if has_processing_after(repository_id, date)
            first_processing_after(repository_id, date)
          elsif has_processing_before(repository_id, date)
            last_processing_before(repository_id, date)
          else
            nil
          end
        end

        def self.has_processing(repository_id)
          Repository.request("#{repository_id}/has_processing")['has_processing']
        end

        def self.has_ready_processing(repository_id)
          Repository.request("#{repository_id}/has_ready_processing", {}, :get)['has_ready_processing']
        end

        def self.has_processing_after(repository_id, date)
          Repository.request("#{repository_id}/has_processing/after", {:date => date})['has_processing_in_time']
        end

        def self.has_processing_before(repository_id, date)
          Repository.request("#{repository_id}/has_processing/before", {:date => date})['has_processing_in_time']
        end

        def self.last_processing_state_of(repository_id)
          Repository.request("#{repository_id}/last_processing_state", {}, :get)['processing_state']
        end

        def self.last_ready_processing_of(repository_id)
          new(request('last_ready_of', {repository_id: repository_id})['processing'])
        end

        def self.first_processing_of(repository_id)
          new(Repository.request("#{repository_id}/first_processing")['processing'])
        end

        def self.last_processing_of(repository_id)
          new(Repository.request("#{repository_id}/last_processing")['processing'])
        end

        def self.first_processing_after(repository_id, date)
          new(Repository.request("#{repository_id}/first_processing/after", {:date => date})["processing"])
        end

        def self.last_processing_before(repository_id, date)
          new(Repository.request("#{repository_id}/last_processing/before", {:date => date})['processing'])
        end
      end
    end
  end
end
