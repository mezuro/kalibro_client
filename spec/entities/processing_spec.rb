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

describe KalibroEntities::Entities::Processing do
  subject {FactoryGirl.build(:processing)}
  
  describe 'id=' do
    it 'should convert the id attribute to integer' do
      subject.id = "41"
      subject.id.should eq 41
    end
  end

  describe 'date=' do
    it 'should set the date attribute' do
      date = DateTime.now
      subject.date  = date
      subject.date.should eq date
    end

    it 'should convert strings to date format' do
      subject.date = "2013-09-17T18:26:43.151+00:00"
      subject.date.should be_kind_of(DateTime)
    end
  end

  describe 'using process_time attribute' do
    before :each do
      @another_process_time = FactoryGirl.build(:analyzing_process_time)
    end

    context 'process_time=' do
      it 'should set the process_time attribute as a list of objects' do
        subject.process_time = @another_process_time.to_hash
        subject.process_time.should eq [@another_process_time]
      end
    end

    context 'process_times=' do
      it 'should set the process_time attribute' do
        subject.process_times = [@another_process_time]
        subject.process_time.should eq [@another_process_time]
      end
    end

    context 'process_times' do
      it 'should get the process_time attribute' do
        subject.process_times.should eq subject.process_time
      end
    end
  end


end