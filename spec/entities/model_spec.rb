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

describe KalibroEntities::Model do
  describe 'new' do
    it 'should create a model from an empty hash' do
      model = KalibroEntities::Model.new {}

      model.errors.should eq([])
    end
  end

  describe 'class_name' do
    subject { KalibroEntities::Model.new {} }

    it 'should be a String' do
      subject.class.class_name.should be_a(String)
    end

    it 'should return Model' do
      subject.class.class_name.should eq('Model')
    end
  end

  describe 'endpoint' do
    it 'should return the class_name' do
      endpoint = 'test'
      KalibroEntities::Model.expects(:class_name).returns(endpoint)

      KalibroEntities::Model.endpoint.should eq(endpoint)
    end
  end

  describe 'client' do
    it 'returns a Savon::Client' do
      KalibroEntities::Model.client('Model').should be_a(Savon::Client)
    end

    it 'accepts an empty endpoint' do

    end
  end

  describe 'request' do
    before(:all) { savon.mock!   }
    after(:all)  { savon.unmock! }

    it 'successfully get the Kalibro version' do
      KalibroEntities::Model.expects(:endpoint).returns('Project')
      fixture = File.read("spec/savon_fixtures/project/does_not_exists.xml")

      savon.expects(:project_exists).with(message: {project_id: 1}).returns(fixture)

      KalibroEntities::Model.request(:project_exists, {project_id: 1})[:exists].should eq(false)
    end
  end
end