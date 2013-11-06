# This file is part of KalibroGem
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

describe KalibroGem::Entities::BaseTool do
  describe 'all_names' do
    context 'with no base tools' do
      before :each do
        KalibroGem::Entities::BaseTool.
          expects(:request).
          with(:all_base_tool_names).
          returns({:base_tool_name => nil})
      end

      it 'should return empty array' do
        KalibroGem::Entities::BaseTool.all_names.should be_empty
      end
    end

    context 'with many base tools' do
      let(:base_tool_hash) { FactoryGirl.build(:base_tool).to_hash }
      let(:another_base_tool_hash) { FactoryGirl.build(:another_base_tool).to_hash }

      before :each do
        KalibroGem::Entities::BaseTool.
          expects(:request).
          with(:all_base_tool_names).
          returns({:base_tool_name => [base_tool_hash, another_base_tool_hash]})
      end

      it 'should return the two elements' do
        base_tool_names = KalibroGem::Entities::BaseTool.all_names

        base_tool_names.size.should eq(2)
        base_tool_names.first.should eq(base_tool_hash)
        base_tool_names.last.should eq(another_base_tool_hash)
      end
    end
  end

  describe 'all' do
    context 'with no base tools' do
      before :each do
        KalibroGem::Entities::BaseTool.
          expects(:request).
          with(:all_base_tool_names).
          returns({:base_tool_name => nil})
      end

      it 'should return empty array' do
        KalibroGem::Entities::BaseTool.all_names.should be_empty
      end
    end

    context 'with many base tools' do
      let(:base_tool) { FactoryGirl.build(:base_tool) }
      let(:another_base_tool) { FactoryGirl.build(:another_base_tool) }

      before :each do
        KalibroGem::Entities::BaseTool.
          expects(:request).
          with(:all_base_tool_names).
          returns({:base_tool_name => [base_tool.name, another_base_tool.name]})
        
        KalibroGem::Entities::BaseTool.
          expects(:request).
          with(:get_base_tool, {:base_tool_name => base_tool.name}).
          returns({:base_tool => base_tool.to_hash})

        KalibroGem::Entities::BaseTool.
          expects(:request).
          with(:get_base_tool, {:base_tool_name => another_base_tool.name}).
          returns({:base_tool => another_base_tool.to_hash})
      end

      it 'should return the two elements' do
        base_tools = KalibroGem::Entities::BaseTool.all

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
        KalibroGem::Entities::BaseTool.
          expects(:request).
          with(:get_base_tool, {:base_tool_name => subject.name}).
          returns({:base_tool => nil})
      end

      it 'should raise a RecordNotFound error' do
        expect { KalibroGem::Entities::BaseTool.find_by_name(subject.name)}.
          to raise_error(KalibroGem::Errors::RecordNotFound)
      end
    end

    context 'with an existent name' do
      before :each do
        KalibroGem::Entities::BaseTool.
          expects(:request).
          with(:get_base_tool,{:base_tool_name => subject.name}).
          returns({:base_tool => subject.to_hash})
      end

      it 'should return a base_tool' do
        KalibroGem::Entities::BaseTool.find_by_name(subject.name).name.should eq(subject.name)
      end
    end
  end

  describe 'Supported Metric' do
    let(:metric) { FactoryGirl.build(:metric) }

    before :each do
      KalibroGem::Entities::Metric.
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