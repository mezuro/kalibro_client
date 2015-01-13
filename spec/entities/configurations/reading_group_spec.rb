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

describe KalibroClient::Entities::Configurations::ReadingGroup do
  describe "id=" do
    subject { FactoryGirl.build(:reading_group) }

    it 'should set the id attribute values as an integer' do
      subject.id = "222"
      expect(subject.id).to eq(222)
    end
  end

  describe 'all' do
    context 'with no reading_groups' do
      before :each do
        KalibroClient::Entities::Configurations::ReadingGroup.
          expects(:request).
          with('', {}, :get).
          returns({'reading_groups' => nil}.to_json)
      end

      it 'should return nil' do
        expect(KalibroClient::Entities::Configurations::ReadingGroup.all).to be_empty
      end
    end

    context 'with many reading_groups' do
      let(:reading_group) { FactoryGirl.build(:reading_group) }
      before :each do
        KalibroClient::Entities::Configurations::ReadingGroup.
          expects(:request).
          with('', {}, :get).
          returns({'reading_groups' => [reading_group.to_hash, reading_group.to_hash]}.to_json)
      end

      it 'should return nil' do
        reading_groups = KalibroClient::Entities::Configurations::ReadingGroup.all

        expect(reading_groups.first.name).to eq(reading_group.name)
        expect(reading_groups.last.name).to eq(reading_group.name)
      end
    end
  end

  # The only purpose of this test is to cover the overrided destroy_params private method
  describe 'destroy' do
    context 'when it gets successfully destroyed' do
      before :each do
        subject.expects(:id).at_least_once.returns(42)
        KalibroClient::Entities::Configurations::ReadingGroup.
          expects(:request).
          with(':id',{id: subject.id}, :delete)
      end

      it 'should remain with the errors array empty' do
        subject.destroy
        expect(subject.kalibro_errors).to be_empty
      end
    end
  end

    # The only purpose of this test is to cover the overrided id_params private method
  describe 'exists?' do
    context 'with an inexistent id' do
      it 'should return false' do
        KalibroClient::Entities::Configurations::ReadingGroup.
          expects(:request).
          with(':id/exists',{id: 0}, :get).
          returns({'exists' => false})
        KalibroClient::Entities::Configurations::ReadingGroup.exists?(0)
      end
    end
  end
end
