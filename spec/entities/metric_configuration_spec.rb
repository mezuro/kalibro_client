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

describe KalibroEntities::Entities::MetricConfiguration do
  describe 'id=' do
    it 'should set the id' do
      subject.id = 42

      subject.id.should eq(42)
    end
  end

  describe 'reading_group_id=' do
    it 'should set the reading group id' do
      subject.reading_group_id = "1"

      subject.reading_group_id.should eq(1)
    end
  end

  describe 'metric=' do
    before do
      @metric = FactoryGirl.build(:metric)
      @metric_hash = @metric.to_hash
    end

    it 'should convert the argument and set the metric' do
      KalibroEntities::Entities::Metric.expects(:to_object).with(@metric_hash).returns(@metric)

      subject.metric = @metric_hash
      subject.metric.should eq(@metric)
    end
  end

  describe 'weight=' do
    it 'should set the weight' do
      subject.weight = 10

      subject.weight.should eq(10)
    end
  end

  describe 'update_attributes' do
    before do
      @metric_configuration = FactoryGirl.build(:metric_configuration)
    end

    it 'should set the attributes and save' do
      KalibroEntities::Entities::MetricConfiguration.any_instance.expects(:save).returns(true)

      subject.update_attributes(@metric_configuration.to_hash)
      subject.id.should eq(@metric_configuration.id)
    end
  end

  describe 'to_hash' do
    subject {FactoryGirl.build(:metric_configuration)}

    it 'should not include the configuration_id' do
      subject.to_hash[:configuration_id].should be_nil
    end
  end

  describe 'find' do
    before do
      @metric_configuration = FactoryGirl.build(:metric_configuration)
      @metric_configuration_hash = @metric_configuration.to_hash
    end

    context 'with and existant MetricConfiguration' do
      before :each do
        KalibroEntities::Entities::MetricConfiguration.
          expects(:request).
          with(:get_metric_configuration, {:metric_configuration_id => @metric_configuration.id}).
          returns({metric_configuration: @metric_configuration_hash})
      end

      it 'should return the metric_configuration' do
        KalibroEntities::Entities::MetricConfiguration.find(@metric_configuration.id).id.should eq(@metric_configuration.id)
      end
    end

    pending "Instantiate a SOAPFault" do
    context 'with an inexistant MetricConfiguration' do
      before :each do
        KalibroEntities::Entities::MetricConfiguration.
          expects(:request).
          with(:get_metric_configuration, {:metric_configuration_id => @metric_configuration.id}).
          raises(Savon::SOAPFault)
      end

      it 'should raise the RecordNotFound error' do
        expect {KalibroEntities::Entities::MetricConfiguration.find(@metric_configuration.id)}.to raise_error(KalibroEntities::Errors::RecordNotFound)
      end
    end
    end
  end

  describe 'metric_configurations_of' do
    before :each do
      @metric_configuration = FactoryGirl.build(:metric_configuration)
      @metric_configuration_hash = @metric_configuration.to_hash
      @configuration_id = 42

      KalibroEntities::Entities::MetricConfiguration.
        expects(:request).
        with(:metric_configurations_of, {:configuration_id => @configuration_id}).
        returns({metric_configuration: @metric_configuration_hash})
    end

    it 'should return a array with a metric configuration' do
      metric_configurations = KalibroEntities::Entities::MetricConfiguration.metric_configurations_of(@configuration_id)

      metric_configurations.should be_an(Array)
      metric_configurations.first.id.should eq(@metric_configuration.id)
    end
  end

  # The only purpose of this test is to cover the overrided save_params method
  describe 'save' do
    subject {FactoryGirl.build(:metric_configuration, {id: nil})}

    before :each do
      KalibroEntities::Entities::MetricConfiguration.
        expects(:request).with(:save_metric_configuration, {:metric_configuration => subject.to_hash, :configuration_id => subject.configuration_id}).returns({:metric_configuration_id => 1})
    end

    it 'should make a request to save model with id and return true without errors' do
      subject.save.should be(true)
      subject.kalibro_errors.should be_empty
    end
  end
end