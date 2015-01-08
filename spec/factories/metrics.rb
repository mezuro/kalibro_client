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

FactoryGirl.define do
  factory :metric, class: KalibroClient::Entities::Miscellaneous::Metric do
    name "Total Abstract Classes"
    code "total_abstract_classes"
    type :native
    scope "SOFTWARE"
    description ""

    initialize_with { KalibroClient::Entities::Miscellaneous::Metric.new(type, name, code, scope) }
  end

  factory :loc, class: KalibroClient::Entities::Miscellaneous::Metric do
    name "Lines of Code"
    code "loc"
    type :native
    scope "CLASS"
    description ""
    
    initialize_with { KalibroClient::Entities::Miscellaneous::Metric.new(type, name, code, scope) }
  end
end
