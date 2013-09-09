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

require 'spec_helper'

describe KalibroEntities::Entities::RangeSnapshot do
  describe 'beginning=' do
    it 'should set the value of the attribute beginning' do
      subject.beginning = 3
      subject.beginning.should eq(3)
    end
  end

  describe 'end=' do
    it 'should set the value of the attribute end' do
      subject.end = 6
      subject.end.should eq(6)
    end
  end

  describe 'grade=' do
    it 'should set the value of the attribute grade' do
      subject.grade = 18
      subject.grade.should eq(18)
    end
  end
end