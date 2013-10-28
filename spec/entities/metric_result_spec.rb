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

describe KalibroEntities::Entities::MetricResult do
  subject { FactoryGirl.build(:metric_result) }
  let(:metric_configuration_snapshot) { FactoryGirl.build(:metric_configuration_snapshot) }

  describe 'new' do
    context 'with value NaN' do
      it 'should set the value with aggregated_value' do
        metric_result = KalibroEntities::Entities::MetricResult.new( FactoryGirl.attributes_for(:metric_result, {value: "NaN", aggregated_value: 1.6}) )
        metric_result.value.should eq(1.6)
      end
    end
  end

  describe 'id=' do
    it 'should set the value of the attribute id' do
      subject.id = 42
      subject.id.should eq(42)
    end
  end

  describe 'configuration=' do
    it 'should set the configuration' do
      subject.configuration = metric_configuration_snapshot.to_hash
      subject.configuration.code.should eq(metric_configuration_snapshot.code)
    end
  end

  describe 'metric_configuration_snapshot' do
    it 'should be an alias to configuration' do
      subject.configuration = metric_configuration_snapshot.to_hash
      subject.metric_configuration_snapshot.code.should eq(metric_configuration_snapshot.code)
    end
  end

  describe 'value=' do
    it 'should set the value of the attribute value' do
      subject.value = 42
      subject.value.should eq(42)
    end
  end

  describe 'aggregated_value=' do
    it 'should set the value of the attribute aggregated_value' do
      subject.aggregated_value = 42
      subject.aggregated_value.should eq(42)
    end
  end

  describe 'descendant_results_of' do
    context 'when there is one descendant result for the given metric_result' do
      before :each do
        KalibroEntities::Entities::MetricResult.
          expects(:request).
          with(:descendant_results_of, { :metric_result_id => subject.id }).
          returns({descendant_result: "13.3"})
      end

      it 'should return an unitary list with the descendant result' do
        subject.descendant_results.should eq([13.3])
      end
    end

    context 'when there is no descendant result for the given metric_result' do
      before :each do
        KalibroEntities::Entities::MetricResult.
          expects(:request).
          with(:descendant_results_of, { :metric_result_id => subject.id }).
          returns({})
      end

      it 'should return an empty list' do
        subject.descendant_results.should eq([])
      end
    end

    context 'when there are many descendant results for the given metric_result' do
      before :each do
        KalibroEntities::Entities::MetricResult.
          expects(:request).
          with(:descendant_results_of, { :metric_result_id => subject.id }).
          returns({descendant_result: ["-13.3", "42.42", "1"]})
      end

      it 'should return a list with the descendant results' do
        subject.descendant_results.should eq([-13.3, 42.42, 1])
      end
    end
  end

  describe 'metric_results_of' do
    context 'when there is one metric result for the given module_result' do
      before :each do
        KalibroEntities::Entities::MetricResult.
          expects(:request).
          with(:metric_results_of, { :module_result_id => 123 }).
          returns({metric_result: subject.to_hash})
      end

      it 'should return an unitary list with the metric result' do
        KalibroEntities::Entities::MetricResult.metric_results_of(123).first.value.should eq(subject.value)
      end
    end

    context 'when there is no metric result for the given module_result' do
      before :each do
        KalibroEntities::Entities::MetricResult.
          expects(:request).
          with(:metric_results_of, { :module_result_id => 42 }).
          returns({})
      end

      it 'should return an empty list' do
        KalibroEntities::Entities::MetricResult.metric_results_of(42).should eq([])
      end
    end

    context 'when there are many metric results for the given module_result' do
      let(:metric_results) { KalibroEntities::Entities::MetricResult.metric_results_of(28) }
      before :each do
        KalibroEntities::Entities::MetricResult.
          expects(:request).
          with(:metric_results_of, { :module_result_id => 28 }).
          returns({metric_result: [subject.to_hash, subject.to_hash]})
      end

      it 'should return a list with the descendant results' do
        metric_results.first.value.should eq(subject.value)
      end
    end
  end

  describe 'history_of' do
    let(:module_result) { FactoryGirl.build(:module_result) }
    let(:metric) { FactoryGirl.build(:metric) }

    context 'when there is not a date metric result' do
      before :each do
        KalibroEntities::Entities::MetricResult.
          expects(:request).
          with(:history_of_metric, {:metric_name => metric.name, :module_result_id => module_result.id}).
          returns({date_metric_result: nil})
      end

      it 'should return an empty list' do
        KalibroEntities::Entities::MetricResult.history_of(metric.name, module_result.id).should eq([])
      end
    end

    context 'when there is only one date metric result' do
      let(:date_metric_result) { FactoryGirl.build(:date_metric_result, {metric_result: subject}) }

      before :each do
        KalibroEntities::Entities::MetricResult.
          expects(:request).
          with(:history_of_metric, {:metric_name => metric.name, :module_result_id => module_result.id}).
          returns({date_metric_result: date_metric_result.to_hash})
      end

      it 'should return the date metric result as an object into a list' do
        KalibroEntities::Entities::MetricResult.history_of(metric.name, module_result.id).
          first.metric_result.id.should eq(subject.id)
      end
    end

    context 'when there is many date metric results' do
      let(:date_metric_result) { FactoryGirl.build(:date_metric_result, {metric_result: subject}) }
      let(:another_date_metric_result) { FactoryGirl.build(:another_date_metric_result, {metric_result: subject}) }

      before :each do
        KalibroEntities::Entities::MetricResult.
          expects(:request).
          with(:history_of_metric, {:metric_name => metric.name, :module_result_id => module_result.id}).
          returns({date_metric_result: [date_metric_result.to_hash, another_date_metric_result.to_hash]})
      end

      it 'should return a list of date metric results as objects' do
        response = KalibroEntities::Entities::MetricResult.history_of(metric.name, module_result.id)
        response.first.metric_result.id.should eq(date_metric_result.metric_result.id)
        response.last.metric_result.id.should eq(another_date_metric_result.metric_result.id)
      end
    end
  end
end
