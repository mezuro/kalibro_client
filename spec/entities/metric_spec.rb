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

describe KalibroClient::Entities::Metric do
  describe 'languages' do
    subject { FactoryGirl.build(:metric) }

    it 'should return the value of the language attribute' do
      expect(subject.languages).to eq(["C", "CPP", "JAVA"])
    end
  end

  describe 'languages=' do
    it 'should set the value of the attribute language' do
      subject.languages = ["Java", "C"]
      expect(subject.languages).to eq(["Java", "C"])
    end
  end

  describe 'language=' do
    before :each do
      KalibroClient::Entities::Metric.
        expects(:to_objects_array).
        returns(["Java"])
    end

    it 'should convert the value to an array of objects' do
      subject.language = "Java"
      expect(subject.languages).to eq(["Java"])
    end
  end

  describe 'compound' do
    context "when it is a supported String" do
      subject { FactoryGirl.build(:metric, compound: "false") }

      it 'is expected to return a Boolean' do
        expect(subject.compound).to be_falsey
      end
    end

    context "when it is a unsupported String" do
      subject { FactoryGirl.build(:metric, compound: "motaboolea") }

      it 'is expected to raise a Error' do
        expect {subject.compound}.to raise_error(ArgumentError)
      end
    end
  end
end
