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
      class MetricCollectorDetails < KalibroClient::Entities::Processor::Base
        attr_accessor :name, :description, :supported_metrics, :wanted_metrics, :processing

        def supported_metrics=(value)
          @supported_metrics = {}
          value.each do |code, metric|
            @supported_metrics[code] = KalibroClient::Entities::Miscellaneous::Metric.new(metric[:type], metric[:name], metric[:code], metric[:scope])
          end
        end

        def metric(name)
          metric = self.supported_metrics.find {|code, metric| metric.name == name}
          metric.nil? ? nil : metric.last
        end

        def self.find_by_name(metric_collector_name)
          begin
            new request(:find, {name: metric_collector_name})["metric_collector_details"]
          rescue
            raise KalibroClient::Errors::RecordNotFound
          end
        end

        def self.all_names
          request(:names, {}, :get)['metric_collector_names'].to_a
        end

        def self.all
          create_objects_array_from_hash(request('', {}, :get))
        end
      end
    end
  end
end
