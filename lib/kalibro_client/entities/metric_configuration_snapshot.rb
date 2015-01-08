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

require "kalibro_client/entities/model"

module KalibroClient
  module Entities
    class MetricConfigurationSnapshot < Model
      attr_accessor :code, :weight, :aggregation_form, :metric, :metric_collector_name, :range

      def weight=(value)
        @weight = value.to_f
      end

      def metric=(value)
        if value.kind_of?(Hash)
          @metric = KalibroClient::Entities::Metric.to_object(value)
        else
          @metric = value
        end
      end

      def range=(value)
        value = [value] unless value.kind_of?(Array)
        @range = []

        value.each do |range_snapshot|
          @range << KalibroClient::Entities::RangeSnapshot.to_object(range_snapshot)
        end
      end

      def range_snapshot
        range
      end

      def to_hash
        hash = super
        hash[:attributes!][:range] = {'xmlns:xsi'=> 'http://www.w3.org/2001/XMLSchema-instance',
          'xsi:type' => 'kalibro:rangeSnapshotXml' }
        hash
      end
    end
  end
end
