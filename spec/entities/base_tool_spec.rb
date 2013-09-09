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

describe KalibroEntities::Entities::BaseTool do
  describe 'all_names' do
    context 'with no base tools' do
      before :each do
        KalibroEntities::Entities::BaseTool.expects(:request).with(:all_base_tool_names).
          returns({:base_tool_name => nil})
      end

      it 'should return empty array' do
        KalibroEntities::Entities::BaseTool.all_names.should be_empty
      end
    end

    context 'with many base tools' do
      before :each do
        @hash = FactoryGirl.build(:base_tool).to_hash
        KalibroEntities::Entities::BaseTool.expects(:request).with(:all_base_tool_names).
          returns({:base_tool_name => [@hash[:name], @hash[:name]]})
      end

      it 'should return the two elements' do
        base_tool_names = KalibroEntities::Entities::BaseTool.all_names

        base_tool_names.size.should eq(2)
        base_tool_names.first.should eq(@hash[:name])
        base_tool_names.last.should eq(@hash[:name])
      end
    end
  end

  describe 'all' do
    context 'with no base tools' do
      before :each do
        KalibroEntities::Entities::BaseTool.expects(:request).with(:all_base_tool_names).
          returns({:base_tool_name => nil})
      end

      it 'should return empty array' do
        KalibroEntities::Entities::BaseTool.all_names.should be_empty
      end
    end

    context 'with many base tools' do
      before :each do
        @hash = FactoryGirl.build(:base_tool).to_hash
        KalibroEntities::Entities::BaseTool.expects(:request).with(:all_base_tool_names).
          returns({:base_tool_name => [@hash[:name], @hash[:name]]})
        KalibroEntities::Entities::BaseTool.expects(:request).at_least_once.with(:get_base_tool, {:base_tool_name => @hash[:name]}).
          returns({:base_tool => @hash})
      end

      it 'should return the two elements' do
        base_tools = KalibroEntities::Entities::BaseTool.all

        base_tools.size.should eq(2)
        base_tools.first.name.should eq(@hash[:name])
        base_tools.last.name.should eq(@hash[:name])
      end
    end
  end

  describe 'find_by_name' do
    before :each do
      @subject = FactoryGirl.build(:base_tool)
      @hash = @subject.to_hash
    end

    context 'with an inexistent name' do
      before :each do
        KalibroEntities::Entities::BaseTool.expects(:request).with(:get_base_tool, {:base_tool_name => @hash[:name]}).
          returns({:base_tool => nil})
      end

      it 'should raise a RecordNotFound error' do
        expect { KalibroEntities::Entities::BaseTool.find_by_name(@hash[:name])}.to raise_error(KalibroEntities::Errors::RecordNotFound)
      end
    end

    context 'with an existent name' do
      before :each do
        KalibroEntities::Entities::BaseTool.expects(:request).with(:get_base_tool,{:base_tool_name => @hash[:name]}).
          returns({:base_tool => @hash})
      end

      it 'should return a base_tool' do
        KalibroEntities::Entities::BaseTool.find_by_name(@hash[:name]).name.should eq(@subject.name)
      end
    end
  end

  context 'Supported Metric' do
    before :each do
      @metric = FactoryGirl.build(:metric)
      @hash = @metric.to_hash
      KalibroEntities::Entities::Metric.expects(:to_objects_array).with(@hash).returns([@metric])
    end

    describe 'supported_metric=' do
      it 'should set the value of the array of supported metrics' do
        subject.supported_metric = @hash
        subject.supported_metric.first.name.should eq(@hash[:name])
      end
    end

    describe 'supported_metrics' do
      it 'should return the array of the supported metrics' do
        subject.supported_metric = @hash
        subject.supported_metrics.first.name.should eq(@hash[:name])
      end
    end
  end
  
  describe 'metric' do
    before :each do
      @subject = FactoryGirl.build(:base_tool)
      @metric = @subject.supported_metrics.first
    end

    it 'should return nil with an inexistent name' do
      @subject.metric("fake name").should be_nil
    end

    it 'should return a metric with an existent name' do
      @subject.metric(@metric.name).name.should eq(@metric.name)
    end
  end
end