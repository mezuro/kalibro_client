# This file is part of KalibroClient
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

describe KalibroClient::Entities::MetricResult do
  subject { FactoryGirl.build(:metric_result) }
  let(:metric_configuration_snapshot) { FactoryGirl.build(:metric_configuration_snapshot) }

  describe 'new' do
    context 'with value NaN' do
      it 'should set the value with aggregated_value' do
        metric_result = KalibroClient::Entities::MetricResult.new( FactoryGirl.attributes_for(:metric_result, {value: "NaN", aggregated_value: 1.6}) )
        expect(metric_result.value).to eq(1.6)
      end
    end
  end

  describe 'id=' do
    it 'should set the value of the attribute id' do
      subject.id = 42
      expect(subject.id).to eq(42)
    end
  end

  describe 'configuration=' do
    it 'should set the configuration' do
      subject.configuration = metric_configuration_snapshot.to_hash
      expect(subject.configuration.code).to eq(metric_configuration_snapshot.code)
    end
  end

  describe 'metric_configuration_snapshot' do
    it 'should be an alias to configuration' do
      subject.configuration = metric_configuration_snapshot.to_hash
      expect(subject.metric_configuration_snapshot.code).to eq(metric_configuration_snapshot.code)
    end
  end

  describe 'value=' do
    it 'should set the value of the attribute value' do
      subject.value = 42
      expect(subject.value).to eq(42)
    end
  end

  describe 'aggregated_value=' do
    it 'should set the value of the attribute aggregated_value' do
      subject.aggregated_value = 42
      expect(subject.aggregated_value).to eq(42)
    end
  end

  describe 'descendant_results_of' do
    context 'when there is one descendant result for the given metric_result' do
      before :each do
        KalibroClient::Entities::MetricResult.
          expects(:request).
          with('descendant_results_of', { id: subject.id }).
          returns({'descendant_results' => [13.3]})
      end

      it 'should return an unitary list with the descendant result' do
        expect(subject.descendant_results).to eq([13.3])
      end
    end

    context 'when there is no descendant result for the given metric_result' do
      before :each do
        KalibroClient::Entities::MetricResult.
          expects(:request).
          with('descendant_results_of', { id: subject.id }).
          returns({'descendant_results' => []})
      end

      it 'should return an empty list' do
        expect(subject.descendant_results).to eq([])
      end
    end
  end

  describe 'metric_results_of' do
    context 'when there is one metric result for the given module_result' do
      before :each do
        KalibroClient::Entities::MetricResult.
          expects(:request).
          with('of', { module_result_id: 123 }).
          returns({'metric_results' => [subject.to_hash]})
      end

      it 'should return an unitary list with the metric result' do
        expect(KalibroClient::Entities::MetricResult.metric_results_of(123).first.value).to eq(subject.value)
      end
    end

    context 'when there is no metric result for the given module_result' do
      before :each do
        KalibroClient::Entities::MetricResult.
          expects(:request).
          with('of', { :module_result_id => 42 }).
          returns({'metric_results' => []})
      end

      it 'should return an empty list' do
        expect(KalibroClient::Entities::MetricResult.metric_results_of(42)).to eq([])
      end
    end

    context 'when there are many metric results for the given module_result' do
      let(:metric_results) { KalibroClient::Entities::MetricResult.metric_results_of(28) }
      before :each do
        KalibroClient::Entities::MetricResult.
          expects(:request).
          with('of', { :module_result_id => 28 }).
          returns({'metric_results' => [subject.to_hash, subject.to_hash]})
      end

      it 'should return a list with the descendant results' do
        expect(metric_results.first.value).to eq(subject.value)
      end
    end
  end

  describe 'history_of' do
    let(:module_result) { FactoryGirl.build(:module_result) }
    let(:metric) { FactoryGirl.build(:metric) }

    context 'when there is not a date metric result' do
      before :each do
        KalibroClient::Entities::MetricResult.
          expects(:request).
          with('history_of_metric', {:metric_name => metric.name, :module_result_id => module_result.id}).
          returns({date_metric_results: []})
      end

      it 'should return an empty list' do
        expect(KalibroClient::Entities::MetricResult.history_of(metric.name, module_result.id)).to eq([])
      end
    end

    context 'when there is only one date metric result' do
      let(:date_metric_result) { FactoryGirl.build(:date_metric_result, {metric_result: subject}) }

      before :each do
        KalibroClient::Entities::MetricResult.
          expects(:request).
          with('history_of_metric', {:metric_name => metric.name, :module_result_id => module_result.id}).
          returns({'date_metric_results' => [date_metric_result.to_hash]})
      end

      it 'should return the date metric result as an object into a list' do
        expect(KalibroClient::Entities::MetricResult.history_of(metric.name, module_result.id).
          first.metric_result.id).to eq(subject.id)
      end
    end

    context 'when there is many date metric results' do
      let(:date_metric_result) { FactoryGirl.build(:date_metric_result, {metric_result: subject}) }
      let(:another_date_metric_result) { FactoryGirl.build(:another_date_metric_result, {metric_result: subject}) }

      before :each do
        KalibroClient::Entities::MetricResult.
          expects(:request).
          with('history_of_metric', {:metric_name => metric.name, :module_result_id => module_result.id}).
          returns({'date_metric_results' => [date_metric_result.to_hash, another_date_metric_result.to_hash]})
      end

      it 'should return a list of date metric results as objects' do
        response = KalibroClient::Entities::MetricResult.history_of(metric.name, module_result.id)
        expect(response.first.metric_result.id).to eq(date_metric_result.metric_result.id)
        expect(response.last.metric_result.id).to eq(another_date_metric_result.metric_result.id)
      end
    end
  end
end
