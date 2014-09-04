# This file is part of KalibroGatekeeperClient
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

FactoryGirl.define do
  factory :metric_collector, class: KalibroGatekeeperClient::Entities::MetricCollector do
    name "Analizo"
    description "Analizo is a suite of source code analysis tools."
    collector_class_name "org.analizo.AnalizoMetricCollector"
    supported_metric { [FactoryGirl.build(:metric), FactoryGirl.build(:metric)] }

    trait :another_metric_collector do
      name "Avalio"
      description "Avalio is another source code analyser that hasn't been developed yet."
    end

    factory  :another_metric_collector, traits: [:another_metric_collector]
  end
end