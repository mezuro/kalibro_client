# This file is part of KalibroGatekeeperClient
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
require 'kalibro_gatekeeper_client/helpers/hash_converters'

include HashConverters

describe HashConverters do
  describe 'date_with_miliseconds' do
    context 'with 21/12/1995 (first Ruby publication)' do
      it 'should return 1995-12-21T00:00:00.0/1+00:00' do
        date_with_milliseconds(DateTime.parse("21/12/1995")).should eq("1995-12-21T00:00:00.0/1+00:00")
      end
    end
  end

  describe 'convert_to_hash' do
    context 'with a nil value' do
      it 'should return nil' do
        convert_to_hash(nil).should be_nil
      end
    end

    context 'with an Array' do
      before :each do
        @array = []
        @element1 = :kalibro

        @array << @element1
      end

      it 'should return the Array wth its elements converted' do
        convert_to_hash(@array)[0].should eq(@element1.to_s)
      end
    end

    context 'with a Model' do
      before :each do
        @model = KalibroGatekeeperClient::Entities::Model.new
      end

      it "should return the Model's Hash" do
        convert_to_hash(@model).should eq(@model.to_hash)
      end
    end

    context 'with a DateTime' do
      before :each do
        @date = DateTime.parse("21/12/1995")
      end

      it 'should return th date with miliseconds' do
        convert_to_hash(@date).should eq(date_with_milliseconds(@date))
      end
    end

    context 'with an + infinite Float' do
      it 'should return INF' do
        convert_to_hash(1.0/0.0).should eq('INF')
      end
    end

    context 'with an - infinite Float' do
      it 'should return -INF' do
        convert_to_hash(-1.0/0.0).should eq('-INF')
      end
    end
  end

  describe 'field_to_hash' do
    context 'with a nil field value' do
      before do
        @model = KalibroGatekeeperClient::Entities::Model.new
        @model.expects(:send).with(:field_getter).returns(nil)
      end

      it 'should return an instance of Hash' do
        @model.field_to_hash(:field_getter).should be_a(Hash)
      end

      it 'should return an empty Hash' do
        @model.field_to_hash(:field_getter).should eq({})
      end
    end

    context 'with a Float field value' do
      before do
        @model = KalibroGatekeeperClient::Entities::Model.new
        @model.expects(:send).with(:field_getter).returns(1.0)
      end

      it 'should return an instance of Hash' do
        @model.field_to_hash(:field_getter).should be_a(Hash)
      end
    end
  end
end