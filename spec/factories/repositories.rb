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
  factory :repository, class: KalibroClient::Entities::Repository do
    id 1
    name "QtCalculator"
    description "A simple calculator"
    license "GPLv3"
    process_period 1
    type "SVN"
    address "svn://svn.code.sf.net/p/qt-calculator/code/trunk"
    configuration_id 1
    project_id 1
    send_email "test@test.com"
  end

  factory :another_repository, class: KalibroClient::Entities::Repository, parent: :repository do
    id 2
  end
end
