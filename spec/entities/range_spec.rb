# This file is part of KalibroGem
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

describe KalibroGem::Entities::Range do
  subject { FactoryGirl.build(:range) }

  describe 'id=' do
    it 'should set the value of the attribute id as an integer' do
      subject.id = "4"
      subject.id.should eq(4)
    end
  end

  describe 'reading_id=' do
    it 'should set the value of the attribute reading_id as an integer' do
      subject.reading_id = "12"
      subject.reading_id.should eq(12)
    end
  end

  describe 'beginning=' do
    it 'should set the value of the attribute as a float' do
      subject.beginning = "12.3"
      subject.beginning.should eq(12.3)
    end

    it 'should set beginning to infinity' do
      subject.beginning = "-INF"
      subject.beginning.should eq("-INF")
    end
  end

  describe 'end=' do
    it 'should set the value of the attribute as a float' do
      subject.end = "23.4"
      subject.end.should eq(23.4)
    end

    it 'should set end to infinity' do
      subject.end = "INF"
      subject.end.should eq("INF")
    end
  end

  describe 'getting reading attribute' do
    let(:reading) { FactoryGirl.build(:reading) }

    before :each do
      KalibroGem::Entities::Reading.
        expects(:find).
        with(subject.reading_id).
        returns(reading)
    end

    context 'label' do
      it 'should get the label of the reading' do
        subject.label.should eq(reading.label)
      end
    end

    context 'grade' do
      it 'should get the grade of the reading' do
        subject.grade.should eq(reading.grade)
      end
    end

    context 'color' do
      it 'should get the color of the reading' do
        subject.color.should eq(reading.color)
      end
    end
  end

  describe 'ranges_of' do
    let(:metric_configuration) { FactoryGirl.build(:metric_configuration) }

    context 'when does not exists the asked range' do
      before :each do
        KalibroGem::Entities::Range.
          expects(:request).
          with(:ranges_of, {metric_configuration_id: metric_configuration.id}).
          returns({range: nil})
      end

      it 'should return a list with the ranges' do
        KalibroGem::Entities::Range.ranges_of(metric_configuration.id).should eq([])
      end
    end

    context 'when exist only one range for the given metric configuration' do
      before :each do
        KalibroGem::Entities::Range.
          expects(:request).
          with(:ranges_of, {metric_configuration_id: metric_configuration.id}).
          returns({range: subject.to_hash})
      end

      it 'should return a list with the range' do
        KalibroGem::Entities::Range.ranges_of(metric_configuration.id).
          first.beginning.should eq(subject.beginning)
      end
    end

    context 'when exists many ranges for the given metric configuration' do
      let(:another_range) { FactoryGirl.build(:another_range) }
      
      before :each do
        KalibroGem::Entities::Range.
          expects(:request).
          with(:ranges_of, {metric_configuration_id: metric_configuration.id}).
          returns({range: [subject.to_hash, another_range.to_hash]})
      end

      it 'should return a list with the ranges' do
        ranges = KalibroGem::Entities::Range.ranges_of(metric_configuration.id)
        ranges.first.comments.should eq(subject.comments)
        ranges.last.comments.should eq(another_range.comments)
      end
    end
  end

  describe 'save' do
    let(:metric_configuration) { FactoryGirl.build(:metric_configuration) }
    
    context 'when kalibro does not save' do
      before :each do
        any_error_message = ""
        any_code = rand(Time.now.to_i)

        KalibroGem::Entities::Range.
          expects(:request).
          with(:save_range, {:range => subject.to_hash, :metric_configuration_id => metric_configuration.id}).
          raises(Savon::SOAPFault.new(any_error_message, any_code))
      end

      it 'should returns false' do
        subject.save(metric_configuration.id).should eq(false)
      end

      it 'should set the error on kalibro_errors attribute' do
        subject.save(metric_configuration.id)
        subject.kalibro_errors.should_not eq([])
      end
    end

    context 'when kalibro saves the range' do
      let(:new_id) { rand(Time.now.to_i) }
      before :each do
        KalibroGem::Entities::Range.
          expects(:request).
          with(:save_range, {:range => subject.to_hash, :metric_configuration_id => metric_configuration.id}).
          returns({range_id: new_id})
      end

      it 'should returns true' do
        subject.save(metric_configuration.id).should eq(true)
      end

      it 'should set the id attribute' do
        subject.save(metric_configuration.id)
        subject.id.should eq(new_id)
      end
    end
  end

  describe 'exists?' do
    context 'when the range exists' do
      before :each do
        KalibroGem::Entities::Range.expects(:find).with(subject.id).returns(subject)
      end

      it 'should return true' do
        KalibroGem::Entities::Range.exists?(subject.id).should be_true
      end
    end

    context 'when the range does not exists' do
      before :each do
        KalibroGem::Entities::Range.expects(:find).with(subject.id).raises(KalibroGem::Errors::RecordNotFound)
      end

      it 'should return false' do
        KalibroGem::Entities::Range.exists?(subject.id).should be_false
      end
    end
  end

  describe 'find' do
    context 'when the range exists' do
      before :each do
        KalibroGem::Entities::Range.
          expects(:all).
          returns([subject])
      end

      it 'should return the range' do
        KalibroGem::Entities::Range.find(subject.id).should eq(subject)
      end
    end

    context "when the range doesn't exists" do
      before :each do
        KalibroGem::Entities::Range.
          expects(:all).
          returns([FactoryGirl.build(:another_range)])
      end

      it 'should raise a RecordNotFound error' do
        expect { KalibroGem::Entities::Range.find(subject.id) }.
          to raise_error(KalibroGem::Errors::RecordNotFound)
      end
    end
  end

  describe 'all' do
    let(:configuration) { FactoryGirl.build(:configuration) }
    let(:metric_configuration) { FactoryGirl.build(:metric_configuration) } 

    before :each do
      KalibroGem::Entities::Configuration.
        expects(:all).
        returns([configuration])
      KalibroGem::Entities::MetricConfiguration.
        expects(:metric_configurations_of).
        with(configuration.id).
        returns([metric_configuration])
      KalibroGem::Entities::Range.
        expects(:ranges_of).
        with(metric_configuration.id).
        returns([subject])
    end

    it 'should list all the ranges' do
      KalibroGem::Entities::Range.all.should include(subject)
    end
  end
end