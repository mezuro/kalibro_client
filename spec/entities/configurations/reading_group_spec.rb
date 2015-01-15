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
    subject { FactoryGirl.build(:reading_group_with_id) }

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
          returns({'reading_groups' => nil})
      end

      it 'should return nil' do
        expect(KalibroClient::Entities::Configurations::ReadingGroup.all).to be_empty
      end
    end

    context 'with many reading_groups' do
      let(:reading_group) { FactoryGirl.build(:reading_group_with_id) }
      before :each do
        KalibroClient::Entities::Configurations::ReadingGroup.
          expects(:request).
          with('', {}, :get).
          returns({'reading_groups' => [reading_group.to_hash, reading_group.to_hash]})
      end

      it 'should return nil' do
        reading_groups = KalibroClient::Entities::Configurations::ReadingGroup.all

        expect(reading_groups.first.name).to eq(reading_group.name)
        expect(reading_groups.last.name).to eq(reading_group.name)
      end
    end
  end
end
