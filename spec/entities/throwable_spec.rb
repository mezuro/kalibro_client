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

describe KalibroGem::Entities::Throwable do
  let(:stack_trace_element) { FactoryGirl.build(:stack_trace_element) }

  describe 'stack_trace_element=' do
    it 'should set the stack trace element' do
      subject.stack_trace_element = stack_trace_element.to_hash
      subject.stack_trace_element.should eq([stack_trace_element])
    end
  end

  describe 'stack_trace' do
    it 'should return the stack trace element' do
      subject.stack_trace_element = stack_trace_element.to_hash
      subject.stack_trace.should eq([stack_trace_element])
    end
  end

  describe 'stack_trace=' do
    it 'should set the stack trace element' do
      subject.stack_trace = [stack_trace_element]
      subject.stack_trace_element.should eq([stack_trace_element])
    end
  end

  describe 'cause=' do
    let(:another_throwable) { FactoryGirl.build(:throwable) }

    it 'should set the cause' do
      subject.cause = another_throwable.to_hash
      subject.cause.should eq(another_throwable)
    end
  end
end