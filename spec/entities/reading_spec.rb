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
    let(:reading) { FactoryGirl.build(:reading) }

    describe 'find' do
      context 'when the reading exists' do
        before :each do
          KalibroEntities::Entities::Reading.
            expects(:request).
            with(:get_reading, {:reading_id => reading.id}).
            returns({:reading => reading.to_hash})
        end

        it 'should return a reading object' do
          response = KalibroEntities::Entities::Reading.find reading.id
          response.label.should eq(reading.label)
        end
      end

      context "when the reading doesn't exists" do
        before :each do
          any_code = rand(Time.now.to_i)
          any_error_message = ""

          KalibroEntities::Entities::Reading.
            expects(:request).
            with(:get_reading, {:reading_id => reading.id}).
            raises(Savon::SOAPFault.new(any_error_message, any_code))
        end

        it 'should return a reading object' do
          expect {KalibroEntities::Entities::Reading.find(reading.id) }.
            to raise_error(KalibroEntities::Errors::RecordNotFound)
        end
      end
    end

    describe 'readings_of' do
      let(:reading_group) { FactoryGirl.build(:reading_group) }
      
      before do
        KalibroEntities::Entities::Reading.
          expects(:request).
          with(:readings_of, {:group_id => reading_group.id}).
          returns({:reading => [reading.to_hash, reading.to_hash]})
      end

      it 'should returns a list of readings that belongs to the given reading group' do
        response = KalibroEntities::Entities::Reading.readings_of reading_group.id
        response.first.label.should eq(reading.label)
        response.last.label.should eq(reading.label)
      end
    end
  end

  # The only purpose of this test is to cover the overrided save_params method
  describe 'save' do
    let(:reading) { FactoryGirl.build(:reading, {id: nil, group_id: FactoryGirl.build(:reading_group).id}) }
    let(:reading_id) { 73 }
    
    before :each do
      KalibroEntities::Entities::Reading.
        expects(:request).
        with(:save_reading, {reading: reading.to_hash, group_id: reading.group_id}).
        returns({:reading_id => reading_id})
    end

    it 'should make a request to save model with id and return true without errors' do
      reading.save.should be(true)
      reading.id.should eq(reading_id)
      reading.kalibro_errors.should be_empty
    end
  end
end