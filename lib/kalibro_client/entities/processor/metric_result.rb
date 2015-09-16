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
      class MetricResult < KalibroClient::Entities::Processor::Base

        # TODO: related_hotspot_metric_results_id should be enclosed to Processor which does not return this id into the response
        #       there should be a controller that returns all the HotspotMetricResults associated through RelatedHotspotMetricResult
        attr_accessor :id, :value, :module_result_id, :metric_configuration_id,
                      :line_number, :message, :related_hotspot_metric_results_id
        attr_reader :metric_configuration

        def id=(value)
          @id = value.to_i
        end

        def metric_configuration_id=(value)
          self.metric_configuration = KalibroClient::Entities::Configurations::MetricConfiguration.request(":id", {id: value.to_i}, :get)["metric_configuration"]
        end

        def metric_configuration=(value)
          @metric_configuration = KalibroClient::Entities::Configurations::MetricConfiguration.to_object value
          @metric_configuration_id = @metric_configuration.id
        end

        def value=(value)
          @value = value.to_f
        end
      end
    end
  end
end
