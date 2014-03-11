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

describe KalibroGatekeeperClient::Entities::BaseTool do
  describe 'all_names' do
    context 'with no base tools' do
      before :each do
        KalibroGatekeeperClient::Entities::BaseTool.
          expects(:request).
          with(:all_names, {}, :get).
          returns({'names' => nil}.to_json)
      end

      it 'should return empty array' do
        KalibroGatekeeperClient::Entities::BaseTool.all_names.should be_empty
      end
    end

    context 'with many base tools' do
      let(:base_tool_hash) { FactoryGirl.build(:base_tool).to_hash }
      let(:another_base_tool_hash) { FactoryGirl.build(:another_base_tool).to_hash }

      before :each do
        KalibroGatekeeperClient::Entities::BaseTool.
          expects(:request).
          with(:all_names, {}, :get).
          returns({'base_tool_names' => [base_tool_hash, another_base_tool_hash]}.to_json)
      end

      it 'should return the two elements' do
        names = KalibroGatekeeperClient::Entities::BaseTool.all_names

        names.size.should eq(2)
        names.first.should eq(JSON.parse(base_tool_hash.to_json))
        names.last.should eq(JSON.parse(another_base_tool_hash.to_json))
      end
    end
  end

  describe 'all' do
    context 'with no base tools' do
      before :each do
        KalibroGatekeeperClient::Entities::BaseTool.
          expects(:request).
          with(:all_names, {}, :get).
          returns({'names' => nil}.to_json)
      end

      it 'should return empty array' do
        KalibroGatekeeperClient::Entities::BaseTool.all_names.should be_empty
      end
    end

    context 'with many base tools' do
      let(:base_tool) { FactoryGirl.build(:base_tool) }
      let(:another_base_tool) { FactoryGirl.build(:another_base_tool) }

      before :each do
        KalibroGatekeeperClient::Entities::BaseTool.
          expects(:request).
          with(:all_names, {}, :get).
          returns({'base_tool_names' => [base_tool.name, another_base_tool.name]}.to_json)
        
        KalibroGatekeeperClient::Entities::BaseTool.
          expects(:request).
          with(:get, {name: base_tool.name}).
          returns(base_tool.to_hash)

        KalibroGatekeeperClient::Entities::BaseTool.
          expects(:request).
          with(:get, {name: another_base_tool.name}).
          returns(another_base_tool.to_hash)
      end

      it 'should return the two elements' do
        base_tools = KalibroGatekeeperClient::Entities::BaseTool.all

        base_tools.size.should eq(2)
        base_tools.first.name.should eq(base_tool.name)
        base_tools.last.name.should eq(another_base_tool.name)
      end
    end
  end

  describe 'find_by_name' do
    subject { FactoryGirl.build(:base_tool) }

    context 'with an inexistent name' do
      before :each do
        KalibroGatekeeperClient::Entities::BaseTool.
          expects(:request).
          with(:get, {name: subject.name}).
          returns(nil)
      end

      it 'should raise a RecordNotFound error' do
        expect { KalibroGatekeeperClient::Entities::BaseTool.find_by_name(subject.name)}.
          to raise_error(KalibroGatekeeperClient::Errors::RecordNotFound)
      end
    end

    context 'with an existent name' do
      before :each do
        KalibroGatekeeperClient::Entities::BaseTool.
          expects(:request).
          with(:get,{name: subject.name}).
          returns(subject.to_hash)
      end

      it 'should return a base_tool' do
        KalibroGatekeeperClient::Entities::BaseTool.find_by_name(subject.name).name.should eq(subject.name)
      end
    end
  end

  describe 'Supported Metric' do
    let(:metric) { FactoryGirl.build(:metric) }

    before :each do
      KalibroGatekeeperClient::Entities::Metric.
        expects(:to_objects_array).at_least_once.
        with(metric.to_hash).
        returns([metric])
    end

    context 'supported_metric=' do
      it 'should set the value of the array of supported metrics' do
        subject.supported_metric = metric.to_hash
        subject.supported_metric.first.name.should eq(metric.name)
      end
    end

    context 'supported_metrics' do
      it 'should return the array of the supported metrics' do
        subject.supported_metric = metric.to_hash
        subject.supported_metrics.first.name.should eq(metric.name)
      end
    end
  end
  
  describe 'metric' do
    subject { FactoryGirl.build(:base_tool) }
    let(:metric) { subject.supported_metrics.first }
    
    it 'should return nil with an inexistent name' do
      subject.metric("fake name").should be_nil
    end

    it 'should return a metric with an existent name' do
      subject.metric(metric.name).name.should eq(metric.name)
    end
  end
end