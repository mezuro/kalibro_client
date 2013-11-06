# This file is part of KalibroGem
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

require "kalibro_gem/entities/model"

module KalibroGem
  module Entities
    class DateMetricResult < Model
      
      attr_accessor :date, :metric_result

      def date=(value)
        @date = value.is_a?(String) ? DateTime.parse(value) : value
      end

      def metric_result=(value)
        @metric_result = KalibroGem::Entities::MetricResult.to_object value
      end
      
      def result
        @metric_result.value
      end
      
    end
  end
end