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

describe KalibroEntities::Entities::Project do
  describe 'id=' do
    it 'should set the value of the attribute id' do
      subject.id = 42
      subject.id.should eq(42)
    end
  end

  describe 'all' do
    context 'with no projects' do
      before :each do
        KalibroEntities::Entities::Project.expects(:request).with(:all_projects).returns({:project => nil})
      end

      it 'should return nil' do
        KalibroEntities::Entities::Project.all.should be_empty
      end
    end

    context 'with many projects' do
      before :each do
        @hash = KalibroEntities::Entities::Project.new.to_hash
        KalibroEntities::Entities::Project.expects(:request).with(:all_projects).returns({:project => [@hash, @hash]})
      end

      it 'should return nil' do
        projects = KalibroEntities::Entities::Project.all

        projects.first.name.should eq(@hash[:name])
        projects.last.name.should eq(@hash[:name])
      end
    end
  end
end