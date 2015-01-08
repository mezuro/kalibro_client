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

describe KalibroClient::Entities::Reading do
  describe "id=" do
    it 'should set the id attribute as an integer' do
      subject.id = "44"
      expect(subject.id).to eq(44)
    end
  end

  describe "grade=" do
    it 'should set the grade attribute as a float' do
      subject.grade = "44.7"
      expect(subject.grade).to eq(44.7)
    end
  end

  context 'static methods' do
    let(:reading) { FactoryGirl.build(:reading) }

    describe 'find' do
      context 'when the reading exists' do
        before :each do
          KalibroClient::Entities::Reading.
            expects(:request).
            with('get', {id: reading.id}).
            returns(reading.to_hash)
        end

        it 'should return a reading object' do
          response = KalibroClient::Entities::Reading.find(reading.id)
          expect(response.label).to eq(reading.label)
        end
      end

      context "when the reading doesn't exists" do
        before :each do
          any_code = rand(Time.now.to_i)
          any_error_message = ""

          KalibroClient::Entities::Reading.
            expects(:request).
            with('get', {id: reading.id}).
            returns({'error' => 'Error'})
        end

        it 'should return a reading object' do
          expect {KalibroClient::Entities::Reading.find(reading.id) }.
            to raise_error(KalibroClient::Errors::RecordNotFound)
        end
      end
    end

    describe 'readings_of' do
      let(:reading_group) { FactoryGirl.build(:reading_group) }

      before do
        KalibroClient::Entities::Reading.
          expects(:request).
          with('of', {reading_group_id: reading_group.id}).
          returns({'readings' => [reading.to_hash, reading.to_hash]})
      end

      it 'should returns a list of readings that belongs to the given reading group' do
        response = KalibroClient::Entities::Reading.readings_of reading_group.id
        expect(response.first.label).to eq(reading.label)
        expect(response.last.label).to eq(reading.label)
      end
    end

    describe 'all' do
      let(:reading_group) { FactoryGirl.build(:reading_group) }

      before :each do
        KalibroClient::Entities::ReadingGroup.
          expects(:all).
          returns([reading_group])
        KalibroClient::Entities::Reading.
          expects(:readings_of).
          with(reading_group.id).
          returns([subject])
      end

      it 'should list all the readings' do
        expect(KalibroClient::Entities::Reading.all).to include(subject)
      end
    end
  end

  # The only purpose of this test is to cover the overrided save_params method
  describe 'save' do
    let(:reading) { FactoryGirl.build(:reading, {id: nil, group_id: FactoryGirl.build(:reading_group).id}) }
    let(:reading_id) { 73 }

    before :each do
      KalibroClient::Entities::Reading.
        expects(:request).
        with('save', {reading: reading.to_hash, reading_group_id: reading.group_id}).
        returns({'id' => reading_id, 'kalibro_errors' => []})
    end

    it 'should make a request to save model with id and return true without errors' do
      expect(reading.save).to be(true)
      expect(reading.id).to eq(reading_id)
      expect(reading.kalibro_errors).to be_empty
    end
  end

  describe 'exists?' do
    subject {FactoryGirl.build(:reading)}

    context 'when the reading exists' do
      before :each do
        KalibroClient::Entities::Reading.expects(:find).with(subject.id).returns(subject)
      end

      it 'should return true' do
        expect(KalibroClient::Entities::Reading.exists?(subject.id)).to be_truthy
      end
    end

    context 'when the reading does not exists' do
      before :each do
        KalibroClient::Entities::Reading.expects(:find).with(subject.id).raises(KalibroClient::Errors::RecordNotFound)
      end

      it 'should return false' do
        expect(KalibroClient::Entities::Reading.exists?(subject.id)).to be_falsey
      end
    end
  end
end
