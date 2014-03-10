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

require 'spec_helper'

describe KalibroGatekeeperClient::Entities::ProcessTime do
  describe 'time=' do
    subject {FactoryGirl.build(:process_time)}

    it 'should set the time attribute to 6' do
      subject.time = 6
      subject.time.should eq 6
    end

    it 'should convert to integer' do
      subject.time = "5"
      subject.time.should eq 5
    end
  end
end