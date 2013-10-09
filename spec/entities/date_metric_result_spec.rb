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

describe KalibroEntities::Entities::DateMetricResult do
  describe 'date=' do
    context 'when the given value is a String' do
      it 'should set the date and convert it to DateTime' do
        subject.date = "21/12/1995" # Ruby's first publication
        
        subject.date.should be_a(DateTime)
        subject.date.should eq(DateTime.parse("21/12/1995"))
      end
    end

    context 'when the given value is something else than a String' do
      it 'should just set the value' do
        subject.date = :something_else

        subject.date.should eq(:something_else)
      end
    end
  end

  describe 'metric_result=' do
    let(:metric_result) { FactoryGirl.build(:metric_result) }

    before :each do
      KalibroEntities::Entities::MetricResult.
        expects(:to_object).
        with(metric_result.to_hash).
        returns(metric_result)
    end

    it 'should set the metric_result with the given one' do
      subject.metric_result = metric_result.to_hash
      subject.metric_result.should eq(metric_result)
    end
  end

  describe 'result' do
    subject { FactoryGirl.build(:date_metric_result) }

    it 'should return the metric result value' do
      subject.result.should eq(10)
    end
  end
end