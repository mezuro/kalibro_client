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

describe KalibroEntities::Entities::Reading do
  describe "id=" do
    it 'should set the id attribute as an integer' do
      subject.id = "44"
      subject.id.should eq(44)
    end
  end

  describe "grade=" do
    it 'should set the grade attribute as a float' do
      subject.grade = "44.7"
      subject.grade.should eq(44.7)
    end
  end

  context 'static methods' do
    before do
      @reading = FactoryGirl.build(:reading)
    end

    describe 'find' do
      before do
        KalibroEntities::Entities::Reading.
          expects(:request).once.
          with(:get_reading, {:reading_id => @reading.id}).
          returns({:reading => @reading.to_hash})
      end

      it 'should return a reading object' do
        response = KalibroEntities::Entities::Reading.find @reading.id
        response.label.should eq(@reading.label)
      end
    end
  
    describe 'readings_of' do
      before do
        @reading_group = FactoryGirl.build(:reading_group)

        KalibroEntities::Entities::Reading.
          expects(:request).once.
          with(:readings_of, {:group_id => @reading_group.id}).
          returns({:reading => [@reading.to_hash, @reading.to_hash]})
      end

      it 'should returns a list of readings that belongs to the given reading group' do
        response = KalibroEntities::Entities::Reading.readings_of @reading_group.id
        response.first.label.should eq(@reading.label)
        response.last.label.should eq(@reading.label)
      end
    end

    describe 'reading_of' do
      pending 'There is no entity Range yet!' do
        before do
          @range = FactoryGirl.build(:range)

          KalibroEntities::Entities::Reading.
            expects(:request).once.
            with(:reading_of, {:range_id => @range.id}).
            returns({:reading => @reading.to_hash})
        end

        it 'should returns a list of readings that belongs to the given reading group' do
          response = KalibroEntities::Entities::Reading.reading_of @range.id
          response.label.should eq(@reading.label)
        end
      end
    end
  end

  # The only purpose of this test is to cover the overrided save_params method
  describe 'save' do
    pending 'mock is not working here' do
      before :each do
        @reading = FactoryGirl.build(:reading, {id: nil})
        @reading_id = 73

        KalibroEntities::Entities::Reading.
          expects(:request).once.
          with(:save_reading, {:reading => @reading.to_hash}).
          returns({:reading_id => @reading_id})
    
        KalibroEntities::Entities::Reading.any_instance.expects(:id=).with(@reading_id).returns(@reading_id)
        KalibroEntities::Entities::Reading.any_instance.expects(:id=).with(nil).returns(nil)
      end

      it 'should make a request to save model with id and return true without errors' do
        @reading.save.should be(true)
        @reading.id.should eq(@reading_id)
        @reading.kalibro_errors.should be_empty
      end
    end
  end
end