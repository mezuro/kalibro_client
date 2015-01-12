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

        attr_accessor :id, :configuration, :value, :aggregated_value

        def initialize(attributes={})
          value = attributes[:value]
          @value = (value == "NaN") ? attributes[:aggregated_value].to_f : value.to_f
          attributes.each do |field, value|
            if field!= :value and field!= :aggregated_value and self.class.is_valid?(field)
              send("#{field}=", value)
            end
          end
          @kalibro_errors = []
        end

        def id=(value)
          @id = value.to_i
        end

        def configuration=(value)
          @configuration = KalibroClient::Entities::Configurations::MetricConfiguration.to_object value
        end

        def metric_configuration
          @configuration
        end

        def value=(value)
          @value = value.to_f
        end

        def aggregated_value=(value)
          @aggregated_value = value.to_i
        end

        def descendant_results
          descendant_results = self.class.request('descendant_results_of', {id: id})['descendant_results']
          descendant_results.map {|descendant_result| descendant_result.to_f}
        end

        def self.metric_results_of(module_result_id)
          create_objects_array_from_hash self.request('of', {module_result_id: module_result_id})['metric_results']
        end

        def self.history_of(metric_name, module_result_id)
          response = self.request('history_of_metric', {:metric_name => metric_name,
                                                        :module_result_id => module_result_id})['date_metric_results']
          create_array_from_hash(response).map { |date_metric_result|
            KalibroClient::Entities::Miscellaneous::DateMetricResult.new date_metric_result }
        end
      end
    end
  end
end
