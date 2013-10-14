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
    class MetricResult < Model

      attr_accessor :id, :configuration, :value, :aggregated_value

      def id=(value)
        @id = value.to_i
      end

      def configuration=(value)
        @configuration = KalibroEntities::Entities::MetricConfigurationSnapshot.to_object value
      end

      def metric_configuration_snapshot
        @configuration
      end

      def value=(value)
        @value = value.to_f
      end

      def aggregated_value=(value)
        @aggregated_value = value.to_i
      end

      def descendant_results
        response = self.class.request(:descendant_results_of, {:metric_result_id => id})[:descendant_result]
        response = [] if response.nil?
        response = [response] if response.is_a?(String)
        response.map {|descendant_result| descendant_result.to_f}
      end

      def self.metric_results_of(module_result_id)
        create_objects_array_from_hash self.request(:metric_results_of, {:module_result_id => module_result_id})[:metric_result]
      end

      def self.history_of(metric_name, module_result_id)
        response = self.request(:history_of_metric, {:metric_name => metric_name,
                                                     :module_result_id => module_result_id})[:date_metric_result]
        create_array_from_hash(response).map { |date_metric_result| KalibroEntities::Entities::DateMetricResult.new date_metric_result }
      end
    end
  end
end
