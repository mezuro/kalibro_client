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

describe KalibroGatekeeperClient::Entities::Range do
  subject { FactoryGirl.build(:range) }

  describe 'id=' do
    it 'should set the value of the attribute id as an integer' do
      subject.id = "4"
      expect(subject.id).to eq(4)
    end
  end

  describe 'reading_id=' do
    it 'should set the value of the attribute reading_id as an integer' do
      subject.reading_id = "12"
      expect(subject.reading_id).to eq(12)
    end
  end

  describe 'beginning=' do
    it 'should set the value of the attribute as a float' do
      subject.beginning = "12.3"
      expect(subject.beginning).to eq(12.3)
    end

    it 'should set beginning to infinity' do
      subject.beginning = "-INF"
      expect(subject.beginning).to eq("-INF")
    end
  end

  describe 'end=' do
    it 'should set the value of the attribute as a float' do
      subject.end = "23.4"
      expect(subject.end).to eq(23.4)
    end

    it 'should set end to infinity' do
      subject.end = "INF"
      expect(subject.end).to eq("INF")
    end
  end

  describe 'getting reading attribute' do
    let(:reading) { FactoryGirl.build(:reading) }

    before :each do
      KalibroGatekeeperClient::Entities::Reading.
        expects(:find).
        with(subject.reading_id).
        returns(reading)
    end

    context 'reading' do
      it 'should return the correct reading' do
        expect(subject.reading).to eq(reading)
      end
    end

    context 'label' do
      it 'should get the label of the reading' do
        expect(subject.label).to eq(reading.label)
      end
    end

    context 'grade' do
      it 'should get the grade of the reading' do
        expect(subject.grade).to eq(reading.grade)
      end
    end

    context 'color' do
      it 'should get the color of the reading' do
        expect(subject.color).to eq(reading.color)
      end
    end
  end

  describe 'ranges_of' do
    let(:metric_configuration) { FactoryGirl.build(:metric_configuration) }

    context 'when does not exists the asked range' do
      before :each do
        KalibroGatekeeperClient::Entities::Range.
          expects(:request).
          with('of', {metric_configuration_id: metric_configuration.id}).
          returns({'ranges' => nil})
      end

      it 'should return a list with the ranges' do
        expect(KalibroGatekeeperClient::Entities::Range.ranges_of(metric_configuration.id)).to eq([])
      end
    end

    context 'when exist only one range for the given metric configuration' do
      before :each do
        KalibroGatekeeperClient::Entities::Range.
          expects(:request).
          with('of', {metric_configuration_id: metric_configuration.id}).
          returns({'ranges' => subject.to_hash})
      end

      it 'should return a list with the range' do
        expect(KalibroGatekeeperClient::Entities::Range.ranges_of(metric_configuration.id).
          first.beginning).to eq(subject.beginning)
      end
    end

    context 'when exists many ranges for the given metric configuration' do
      let(:another_range) { FactoryGirl.build(:another_range) }

      before :each do
        KalibroGatekeeperClient::Entities::Range.
          expects(:request).
          with('of', {metric_configuration_id: metric_configuration.id}).
          returns({'ranges' => [subject.to_hash, another_range.to_hash]})
      end

      it 'should return a list with the ranges' do
        ranges = KalibroGatekeeperClient::Entities::Range.ranges_of(metric_configuration.id)
        expect(ranges.first.comments).to eq(subject.comments)
        expect(ranges.last.comments).to eq(another_range.comments)
      end
    end
  end

  # The only purpose of this test is to cover the overrided save_params method
  describe 'save' do
    subject {FactoryGirl.build(:range, {id: nil})}

    before :each do
      KalibroGatekeeperClient::Entities::Range.
        expects(:request).
        with('save', {:range => subject.to_hash, :metric_configuration_id => subject.metric_configuration_id}).
        returns({'id' => 2, 'kalibro_errors' => []})
    end

    it 'should make a request to save model with id and return true without errors' do
      expect(subject.save).to be(true)
      expect(subject.kalibro_errors).to be_empty
    end
  end

  describe 'exists?' do
    context 'when the range exists' do
      before :each do
        KalibroGatekeeperClient::Entities::Range.expects(:find).with(subject.id).returns(subject)
      end

      it 'should return true' do
        expect(KalibroGatekeeperClient::Entities::Range.exists?(subject.id)).to be_truthy
      end
    end

    context 'when the range does not exists' do
      before :each do
        KalibroGatekeeperClient::Entities::Range.expects(:find).with(subject.id).raises(KalibroGatekeeperClient::Errors::RecordNotFound)
      end

      it 'should return false' do
        expect(KalibroGatekeeperClient::Entities::Range.exists?(subject.id)).to be_falsey
      end
    end
  end

  describe 'find' do
    context 'when the range exists' do
      before :each do
        KalibroGatekeeperClient::Entities::Range.
          expects(:all).
          returns([subject])
      end

      it 'should return the range' do
        expect(KalibroGatekeeperClient::Entities::Range.find(subject.id)).to eq(subject)
      end
    end

    context "when the range doesn't exists" do
      before :each do
        KalibroGatekeeperClient::Entities::Range.
          expects(:all).
          returns([FactoryGirl.build(:another_range)])
      end

      it 'should raise a RecordNotFound error' do
        expect { KalibroGatekeeperClient::Entities::Range.find(subject.id) }.
          to raise_error(KalibroGatekeeperClient::Errors::RecordNotFound)
      end
    end
  end

  describe 'all' do
    let(:configuration) { FactoryGirl.build(:configuration) }
    let(:metric_configuration) { FactoryGirl.build(:metric_configuration) }

    before :each do
      KalibroGatekeeperClient::Entities::Configuration.
        expects(:all).
        returns([configuration])
      KalibroGatekeeperClient::Entities::MetricConfiguration.
        expects(:metric_configurations_of).
        with(configuration.id).
        returns([metric_configuration])
      KalibroGatekeeperClient::Entities::Range.
        expects(:ranges_of).
        with(metric_configuration.id).
        returns([subject])
    end

    it 'should list all the ranges' do
      expect(KalibroGatekeeperClient::Entities::Range.all).to include(subject)
    end
  end
end
