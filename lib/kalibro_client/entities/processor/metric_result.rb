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

        attr_accessor :id, :value, :aggregated_value, :module_result_id, :metric_configuration_id
        attr_reader :metric_configuration

        def initialize(attributes={}, persisted=false)
          value = attributes["value"]
          @value = (value == "NaN") ? attributes["aggregated_value"].to_f : value.to_f
          attributes.each do |field, value|
            if field!= "value" and field!= "aggregated_value" and self.class.is_valid?(field)
              send("#{field}=", value)
            end
          end
          @kalibro_errors = []
          @persisted = persisted
        end

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

        def aggregated_value=(value)
          @aggregated_value = value.to_f
        end

        def descendant_values
          descendant_values = self.class.request(':id/descendant_values', {id: id}, :get)['descendant_values']
          descendant_values.map {|descendant_value| descendant_value.to_f}
        end

        # def self.metric_results_of(module_result_id)
        #   puts "DEPRECATED: MetricResult.metric_results_of"
        #   KalibroClient::Entities::Processor::ModuleResult.find(module_result_id).metric_results
        # end

        def self.history_of(metric_name, kalibro_module_id, repository_id)
          response = Repository.request(':id/metric_result_history_of', {metric_name: metric_name,
                                                        kalibro_module_id: kalibro_module_id,
                                                        id: repository_id})['metric_result_history_of']
          response.map { |date_metric_result|
            KalibroClient::Entities::Miscellaneous::DateMetricResult.new date_metric_result }
        end
      end
    end
  end
end
