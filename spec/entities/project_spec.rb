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

describe KalibroGatekeeperClient::Entities::Project do
  describe 'initialize' do
    subject { FactoryGirl.build(:project, {id: 42}) }

    it 'should have the id set to 42' do
      subject.id.should eq(42)
    end
  end

  describe 'id=' do
    it 'should set the value of the attribute id as integer' do
      subject.id = "42"
      subject.id.should eq(42)
    end
  end

  describe 'all' do
    context 'with no projects' do
      before :each do
        KalibroGatekeeperClient::Entities::Project.
          expects(:request).
          with('all', {}, :get).
          returns({:projects => nil}.to_json)
      end

      it 'should return nil' do
        KalibroGatekeeperClient::Entities::Project.all.should be_empty
      end
    end

    context 'with many projects' do
      let(:project) { FactoryGirl.build(:project) }
      let(:another_project) { FactoryGirl.build(:another_project) }

      before :each do
        KalibroGatekeeperClient::Entities::Project.
            expects(:request).
            with('all', {}, :get).
            returns({:projects => [project.to_hash, another_project.to_hash]}.to_json)
      end

      it 'should return a list with projects' do
        projects = KalibroGatekeeperClient::Entities::Project.all

        projects.first.name.should eq(project.name)
        projects.last.name.should eq(another_project.name)
      end
    end
  end
end