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

describe KalibroEntities::Entities::ModuleResult do
  before :each do
    @module_result = FactoryGirl.build(:module_result, id: rand(Time.now.to_i))
  end

  describe 'find' do
    context 'when there is a module result for the given id' do
      before :each do
        KalibroEntities::Entities::ModuleResult.
          expects(:request).
          with(:get_module_result, { :module_result_id => @module_result.id }).
          returns({module_result: @module_result.to_hash})
      end

      it 'should return a hash with module result' do
        KalibroEntities::Entities::ModuleResult.find(@module_result.id).id.should eq(@module_result.id)
      end
    end

    context "when there isn't a module result for the given id" do
      before :each do
        any_code = rand(Time.now.to_i)
        any_error_message = ""

        KalibroEntities::Entities::ModuleResult.
          expects(:request).
          with(:get_module_result, { :module_result_id => @module_result.id }).
          raises(Savon::SOAPFault.new(any_error_message, any_code))
      end

      it 'should raise an error' do
        expect {KalibroEntities::Entities::ModuleResult.find(@module_result.id)}.
          to raise_error KalibroEntities::Errors::RecordNotFound
      end
    end
  end

  describe 'children' do
    before :each do
      KalibroEntities::Entities::ModuleResult.
      expects(:request).
      with(:children_of, {:module_result_id => @module_result.id}).
      returns({module_result: @module_result.to_hash})
    end

    it 'should return a list of a objects' do
      @module_result.children.should eq [@module_result]
    end
  end

  describe 'parents' do
    before do
      @root_module_result = FactoryGirl.build(:root_module_result)
    end

    context 'when module result has a parent' do
      before :each do
        KalibroEntities::Entities::ModuleResult.
          expects(:request).at_least_once.
          with(:get_module_result, { :module_result_id => @module_result.parent_id }).
          returns({module_result: @root_module_result.to_hash})
      end

      it 'should return its parent' do
        @module_result.parents.should eq [@root_module_result]
      end
    end

    context 'when module result does not have a parent' do
      it 'should return an empty list' do
        @root_module_result.parents.should eq []
      end
    end
  end

  describe 'id=' do
    it 'should set the id attribute as integer' do
      @module_result.id = "23"
      @module_result.id.should eq 23
    end
  end

  describe 'module=' do
    before :each do
      @another_module = FactoryGirl.build(:module, name: 'ANOTHER')
    end

    it 'should set the module attribute as a Module object' do
      @module_result.module = @another_module.to_hash
      @module_result.module.should eq @another_module
    end
  end

  describe 'grade=' do
    it 'should set the grade attribute as float' do
      @module_result.grade = "12.5"
      @module_result.grade.should eq 12.5
    end
  end

  describe 'parent_id=' do
    it 'should set the parent_id attribute as integer' do
      @module_result.parent_id = "73"
      @module_result.parent_id.should eq 73
    end
  end

  describe 'history_of' do
    before :each do
      @date_module_result = FactoryGirl.build(:date_module_result)

      KalibroEntities::Entities::ModuleResult.
      expects(:request).
      with(:history_of_module, {:module_result_id => @module_result.id}).
      returns({date_module_result: @date_module_result.to_hash})
    end

    it 'should return a list of date_module_results' do
      @date_module_results = KalibroEntities::Entities::ModuleResult.history_of @module_result.id
      @date_module_results.first.result.should eq @date_module_result.result
    end
  end
end