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

describe KalibroEntities::Entities::RepositoryObserver do
  describe 'id=' do
    it 'should set the value of the attribute id' do
      subject.id = 42
      subject.id.should eq(42)
    end
  end

  describe 'all' do
    context 'with no repository observers' do
      before :each do
        KalibroEntities::Entities::RepositoryObserver.expects(:request).with(:all_repository_observers).
          returns({:repository_observer => nil})
      end

      it 'should return nil' do
        KalibroEntities::Entities::RepositoryObserver.all.should be_empty
      end
    end

    context 'with many repository observers' do
      before :each do
        @hash = FactoryGirl.build(:repository_observer).to_hash
        KalibroEntities::Entities::RepositoryObserver.expects(:request).with(:all_repository_observers).
          returns({:repository_observer => [@hash, @hash]})
      end

      it 'should return the two elements' do
        repository_observers = KalibroEntities::Entities::RepositoryObserver.all

        repository_observers.size.should eq(2)
        repository_observers.first.name.should eq(@hash[:name])
        repository_observers.last.name.should eq(@hash[:name])
      end
    end
  end
end