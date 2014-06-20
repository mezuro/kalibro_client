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

describe KalibroGatekeeperClient::Entities::MetricConfigurationSnapshot do
  describe 'weight=' do
    it 'should set the value of the attribute weight' do
      subject.weight = "0.6"
      expect(subject.weight).to eq(0.6)
    end
  end

  describe 'metric=' do
    let(:metric) { FactoryGirl.build(:metric) }

    context 'when it is not a hash' do
      it 'should set the value of the attribute metric' do
        subject.metric = metric
        expect(subject.metric).to eq(metric)
      end
    end

    context 'When it is a hash' do
      before :each do
        KalibroGatekeeperClient::Entities::Metric.
          expects(:to_object).
          at_least_once.
          with(metric.to_hash).
          returns(metric)
      end

      it 'should set the value of the attribute metric as an object' do
        subject.metric = metric.to_hash
        expect(subject.metric).to eq(metric)
      end
    end
  end

  describe 'range=' do
    let(:range_snapshot) { FactoryGirl.build(:range_snapshot) }
    let(:range_snapshot_hash) { range_snapshot.to_hash }

    context 'with a single range' do
      before :each do
        KalibroGatekeeperClient::Entities::RangeSnapshot.
          expects(:to_object).
          with(range_snapshot_hash).
          returns(range_snapshot)
      end

      it 'should set the value of the attribute range' do
        subject.range = range_snapshot_hash
        expect(subject.range).to eq([range_snapshot])
      end
    end

    context 'with a list of many ranges' do
      before :each do
        KalibroGatekeeperClient::Entities::RangeSnapshot.
          expects(:to_object).
          twice.with(range_snapshot_hash).
          returns(range_snapshot)
      end

      it 'should set the value of the attribute range' do
        subject.range = [range_snapshot_hash, range_snapshot_hash]
        ranges = subject.range
        expect(ranges.size).to eq(2)
        expect(ranges.first).to eq (range_snapshot)
        expect(ranges.last).to eq (range_snapshot)
      end
    end
  end

  describe 'range_snapshot' do
    subject { FactoryGirl.build(:metric_configuration_snapshot) }

    it 'should return the value of the range attribute' do
      expect(subject.range_snapshot).to eq(subject.range)
    end
  end

  describe 'to_hash' do
    subject {FactoryGirl.build(:metric_configuration_snapshot)}

    it 'should override the default to_hash method' do
      hash = subject.to_hash
      expect(hash[:attributes!][:range]).
        to eq({'xmlns:xsi'=> 'http://www.w3.org/2001/XMLSchema-instance',
                   'xsi:type' => 'kalibro:rangeSnapshotXml' })
    end
  end
end