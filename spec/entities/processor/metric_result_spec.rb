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
  subject { FactoryGirl.build(:metric_result) }

  before do
    KalibroClient::Entities::Configurations::MetricConfiguration.
      stubs(:request).
      with(':id', {id: metric_configuration.id}, :get).
      returns({'metric_configuration' => metric_configuration.to_hash})
  end

  describe 'id=' do
    it 'should set the value of the attribute id' do
      subject.id = 42
      expect(subject.id).to eq(42)
    end
  end

  describe 'metric_configuration=' do
    it 'should set the metric configuration' do
      subject.metric_configuration = metric_configuration
      expect(subject.metric_configuration.weight).to eq(metric_configuration.weight)
      expect(subject.metric_configuration.aggregation_form).to eq(metric_configuration.aggregation_form)
      expect(subject.metric_configuration.reading_group_id).to eq(metric_configuration.reading_group_id)
      expect(subject.metric_configuration.kalibro_configuration_id).to eq(metric_configuration.kalibro_configuration_id)
      expect(subject.metric_configuration_id).to eq(metric_configuration.id)
    end
  end

  describe 'value=' do
    it 'should set the value of the attribute value' do
      subject.value = 42
      expect(subject.value).to eq(42)
    end
  end
end
