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
  before :each do
    @metric_result = FactoryGirl.build(:metric_result)
  end

  describe 'descendant_results_of' do
    context 'when there is one descendant result for the given metric_result' do
      before :each do
        KalibroEntities::Entities::MetricResult.
          expects(:request).
          with(:descendant_results_of, { :metric_result_id => @metric_result.id }).
          returns({descendant_result: "13.3"})
      end

      it 'should return an unitary list with the descendant result' do
        @metric_result.descendant_results.should eq([13.3])
      end
    end

    context 'when there is no descendant result for the given metric_result' do
      before :each do
        KalibroEntities::Entities::MetricResult.
          expects(:request).
          with(:descendant_results_of, { :metric_result_id => @metric_result.id }).
          returns({})
      end

      it 'should return an empty list' do
        @metric_result.descendant_results.should eq([])
      end
    end

    context 'when there are many descendant results for the given metric_result' do
      before :each do
        KalibroEntities::Entities::MetricResult.
          expects(:request).
          with(:descendant_results_of, { :metric_result_id => @metric_result.id }).
          returns({descendant_result: ["-13.3", "42.42", "1"]})
      end

      it 'should return a list with the descendant results' do
        @metric_result.descendant_results.should eq([-13.3, 42.42, 1])
      end
    end
  end

  describe 'metric_results_of' do
    context 'when there is one metric result for the given module_result' do
      before :each do
        KalibroEntities::Entities::MetricResult.
          expects(:request).
          with(:metric_results_of, { :module_result_id => 123 }).
          returns({metric_result: @metric_result.to_hash})
      end

      it 'should return an unitary list with the metric result' do
        KalibroEntities::Entities::MetricResult.metric_results_of(123).first.value.should eq(@metric_result.value)
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
      before :each do
        KalibroEntities::Entities::MetricResult.
          expects(:request).
          with(:metric_results_of, { :module_result_id => 28 }).
          returns({metric_result: [@metric_result.to_hash, @metric_result.to_hash]})
        @metric_results = KalibroEntities::Entities::MetricResult.metric_results_of(28)
      end

      it 'should return a list with the descendant results' do
        @metric_results.first.value.should eq(@metric_result.value)
        @metric_results.last.aggregated_value.should eq(@metric_result.aggregated_value)
      end
    end
  end
end
