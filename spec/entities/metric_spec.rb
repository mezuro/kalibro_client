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

describe KalibroGatekeeperClient::Entities::Metric do
  describe 'languages' do
    subject { FactoryGirl.build(:metric) }

    it 'should return the value of the language attribute' do
      subject.languages.should eq(["C", "CPP", "JAVA"])
    end
  end

  describe 'languages=' do
    it 'should set the value of the attribute language' do
      subject.languages = ["Java", "C"]
      subject.languages.should eq(["Java", "C"])
    end
  end

  describe 'language=' do
    before :each do
      KalibroGatekeeperClient::Entities::Metric.
        expects(:to_objects_array).
        returns(["Java"])
    end

    it 'should convert the value to an array of objects' do
      subject.language = "Java"
      subject.languages.should eq(["Java"])
    end
  end
end