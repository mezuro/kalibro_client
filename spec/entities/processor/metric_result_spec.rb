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

describe KalibroClient::Entities::Processor::MetricResult do
  let(:metric_configuration) { FactoryGirl.build(:metric_configuration_with_id) }
  subject { FactoryGirl.build(:metric_result, configuration: metric_configuration) }

  describe 'new' do
    context 'with value NaN' do
      it 'should set the value with aggregated_value' do
        attributes_hash = FactoryGirl.build(:metric_result, {"aggregated_value" => 1.6}).to_hash
        attributes_hash["value"] = "NaN"
        metric_result = KalibroClient::Entities::Processor::MetricResult.new(attributes_hash)
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
      subject.configuration = metric_configuration.to_hash
      expect(subject.configuration.weight).to eq(metric_configuration.weight)
      expect(subject.configuration.aggregation_form).to eq(metric_configuration.aggregation_form)
      expect(subject.configuration.reading_group_id).to eq(metric_configuration.reading_group_id)
      expect(subject.configuration.kalibro_configuration_id).to eq(metric_configuration.kalibro_configuration_id)
    end
  end

  describe 'metric_configuration' do
    it 'should return the metric configuration' do
      expect(subject.metric_configuration).to eq(metric_configuration)
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

  describe 'descendant_values' do
    context 'when there is one descendant value for the given metric_result' do
      before :each do
        KalibroClient::Entities::Processor::MetricResult.
          expects(:request).
          with(':id/descendant_values', { id: subject.id }, :get).
          returns({'descendant_values' => [13.3]})
      end

      it 'should return an unitary list with the descendant value' do
        expect(subject.descendant_values).to eq([13.3])
      end
    end

    context 'when there is no descendant value for the given metric_result' do
      before :each do
        KalibroClient::Entities::Processor::MetricResult.
          expects(:request).
          with(':id/descendant_values', { id: subject.id }, :get).
          returns({'descendant_values' => []})
      end

      it 'should return an empty list' do
        expect(subject.descendant_values).to eq([])
      end
    end
  end

  describe 'metric_results_of' do
    context 'when there is one metric result for the given module_result' do
      before :each do
        KalibroClient::Entities::Processor::ModuleResult.
          expects(:request).
          with(':id/metric_results', { id: 123 }, :get).
          returns({'metric_results' => [subject.to_hash]})
      end

      it 'should return an unitary list with the metric result' do
        expect(KalibroClient::Entities::Processor::MetricResult.metric_results_of(123).first.value).to eq(subject.value)
      end
    end

    context 'when there is no metric result for the given module_result' do
      before :each do
        KalibroClient::Entities::Processor::ModuleResult.
          expects(:request).
          with(':id/metric_results', { :id => 42 }, :get).
          returns({'metric_results' => []})
      end

      it 'should return an empty list' do
        expect(KalibroClient::Entities::Processor::MetricResult.metric_results_of(42)).to eq([])
      end
    end

    context 'when there are many metric results for the given module_result' do
      before :each do
        KalibroClient::Entities::Processor::ModuleResult.
          expects(:request).
          with(':id/metric_results', { :id => 28 }, :get).
          returns({'metric_results' => [subject.to_hash, subject.to_hash]})
      end

      it 'should return a list with the descendant results' do
        expect(KalibroClient::Entities::Processor::MetricResult.metric_results_of(28).first.value).to eq(subject.value)
      end
    end
  end

  describe 'history_of' do
    let(:module_result) { FactoryGirl.build(:module_result) }
    let(:metric) { FactoryGirl.build(:metric) }

    context 'when there is not a date metric result' do
      before :each do
        KalibroClient::Entities::Processor::MetricResult.
          expects(:request).
          with('history_of_metric', {:metric_name => metric.name, :module_result_id => module_result.id}).
          returns({date_metric_results: []})
      end

      it 'should return an empty list' do
        expect(KalibroClient::Entities::Processor::MetricResult.history_of(metric.name, module_result.id)).to eq([])
      end
    end

    context 'when there is only one date metric result' do
      let!(:date_metric_result) { FactoryGirl.build(:date_metric_result, metric_result: subject.to_hash) }

      before :each do
        KalibroClient::Entities::Processor::MetricResult.
          expects(:request).with('history_of_metric', {:metric_name => metric.name, :module_result_id => module_result.id}).returns({'date_metric_results' => [date_metric_result.to_hash]})
      end

      it 'should return the date metric result as an object into a list' do
        expect(KalibroClient::Entities::Processor::MetricResult.history_of(metric.name, module_result.id).first.metric_result.id).to eq(subject.id)
      end
    end

    context 'when there is many date metric results' do
      let(:date_metric_result) { FactoryGirl.build(:date_metric_result, {metric_result: subject.to_hash}) }
      let(:another_date_metric_result) { FactoryGirl.build(:another_date_metric_result, {metric_result: subject.to_hash}) }

      before :each do
        KalibroClient::Entities::Processor::MetricResult.
          expects(:request).
          with('history_of_metric', {:metric_name => metric.name, :module_result_id => module_result.id}).
          returns({'date_metric_results' => [date_metric_result.to_hash, another_date_metric_result.to_hash]})
      end

      it 'should return a list of date metric results as objects' do
        response = KalibroClient::Entities::Processor::MetricResult.history_of(metric.name, module_result.id)
        expect(response.first.metric_result.id).to eq(date_metric_result.metric_result.id)
        expect(response.last.metric_result.id).to eq(another_date_metric_result.metric_result.id)
      end
    end
  end
end
