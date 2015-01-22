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

describe KalibroClient::Entities::Processor::ModuleResult do
  subject { FactoryGirl.build(:module_result, id: rand(Time.now.to_i)) }

  describe 'find' do
    context 'when there is a module result for the given id' do
      before :each do
        KalibroClient::Entities::Processor::ModuleResult.
          expects(:request).
          with(':id/exists', { id: subject.id }, :get).
          returns("exists" => true)
        KalibroClient::Entities::Processor::ModuleResult.
          expects(:request).
          with(':id', { id: subject.id }, :get).
          returns("module_result" => subject.to_hash)
      end

      it 'should return a hash with module result' do
        expect(KalibroClient::Entities::Processor::ModuleResult.
          find(subject.id).id).to eq(subject.id)
      end
    end

    context "when there isn't a module result for the given id" do
      before :each do
        KalibroClient::Entities::Processor::ModuleResult.
          expects(:request).
          with(':id/exists', { id: subject.id }, :get).
          returns("exists" => false)
      end

      it 'should raise an error' do
        expect {KalibroClient::Entities::Processor::ModuleResult.find(subject.id)}.
          to raise_error KalibroClient::Errors::RecordNotFound
      end
    end
  end

  describe 'children' do
    before :each do
      KalibroClient::Entities::Processor::ModuleResult.
        expects(:request).
        with(':id/children', {id: subject.id}, :get).
        returns({'module_results' => subject.to_hash})
    end

    it 'should return a list of objects' do
      expect(subject.children).to eq [subject]
    end
  end

  describe 'parents' do
    let(:root_module_result) { FactoryGirl.build(:root_module_result) }

    context 'when module result has a parent' do
      before :each do
        KalibroClient::Entities::Processor::ModuleResult.
          expects(:request).
          with(':id/exists', { id: subject.parent_id }, :get).
          returns("exists" => true)
        KalibroClient::Entities::Processor::ModuleResult.
          expects(:request).at_least_once.
          with(':id', { id: subject.parent_id }, :get).
          returns("module_result" => root_module_result.to_hash)
      end

      it 'should return its parent' do
        expect(subject.parents).to eq [root_module_result]
      end
    end

    context 'when module result does not have a parent' do
      it 'should return an empty list' do
        expect(root_module_result.parents).to eq []
      end
    end
  end

  describe 'id=' do
    it 'should set the id attribute as integer' do
      subject.id = 23
      expect(subject.id).to eq 23
    end
  end

  describe 'kalibro_module' do
    let(:kalibro_module) { FactoryGirl.build(:kalibro_module) }

    before :each do
      KalibroClient::Entities::Processor::ModuleResult.
          expects(:request).once.
          with(':id/kalibro_module', { id: subject.id }, :get).
          returns("kalibro_module" => kalibro_module.to_hash)
    end

    it 'should return the kalibro_module' do
      expect(subject.kalibro_module).to eq(kalibro_module)
    end

    it 'should not request the kalibro_module in cache' do
      expect(subject.kalibro_module).to eq(kalibro_module)
    end
  end

  describe 'grade=' do
    it 'should set the grade attribute as float' do
      subject.grade = 12.5
      expect(subject.grade).to eq 12.5
    end
  end

  describe 'parent_id=' do
    it 'should set the parent_id attribute as integer' do
      subject.parent_id = 73
      expect(subject.parent_id).to eq 73
    end
  end

  describe 'history_of' do
    let(:date_module_result) { FactoryGirl.build(:date_module_result) }
    before :each do
      KalibroClient::Entities::Processor::ModuleResult.
        expects(:request).
        with('history_of', {id: subject.id}).
        returns({'date_module_results' => [[date_module_result.date, date_module_result.module_result.to_hash]]})
    end

    it 'should return a list of date_module_results' do
      date_module_results = KalibroClient::Entities::Processor::ModuleResult.history_of subject.id
      expect(date_module_results.first.result).to eq date_module_result.result
    end
  end

  describe 'folder? & file?' do
    context 'when the module result has childrens' do
      subject { FactoryGirl.build(:root_module_result) }

      before :each do
        subject.expects(:children).twice.returns([FactoryGirl.build(:module_result)])
      end

      it 'should return true for folder? and false for file?' do
        expect(subject.folder?).to be_truthy
        expect(subject.file?).to be_falsey
      end
    end

    context 'when the module result has no childrens' do
      subject { FactoryGirl.build(:module_result) }

      before :each do
        subject.expects(:children).twice.returns([])
      end

      it 'should return true for folder? and false for file?' do
        expect(subject.folder?).to be_falsey
        expect(subject.file?).to be_truthy
      end
    end
  end
end
