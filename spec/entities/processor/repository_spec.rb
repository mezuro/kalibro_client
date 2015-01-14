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

describe KalibroClient::Entities::Processor::Repository do
  subject { FactoryGirl.build(:repository) }

  describe 'repository_types' do
    before :each do
      KalibroClient::Entities::Processor::Repository.
        expects(:request).
        with('types', {}, :get).
        returns({'types'=>["BAZAAR", "GIT", "MERCURIAL", "REMOTE_TARBALL", "REMOTE_ZIP"]})
    end

    it 'should return an array of repository types' do
      expect(KalibroClient::Entities::Processor::Repository.repository_types).to eq(["BAZAAR", "GIT", "MERCURIAL", "REMOTE_TARBALL", "REMOTE_ZIP"])
    end
  end

  describe 'repositories_of' do
    before :each do
      KalibroClient::Entities::Processor::Repository.
        expects(:request).
        with('of', {project_id: 1}, :get).
        returns({'repositories' => []})
    end

    it 'should return an array' do
      expect(KalibroClient::Entities::Processor::Repository.repositories_of(1)).to be_an(Array)
    end

    it 'should set the repository_id' do
      KalibroClient::Entities::Processor::Repository.repositories_of(1).each do |repository|
        expect(repository.project_id).to eq(1)
      end
    end
  end

  describe "id=" do
    it 'should set the id attribute values as integer' do
      subject.id = "222"
      expect(subject.id).to eq(222)
    end
  end

  describe "process_period=" do
    it 'should set the process_period attribute values as integer' do
      subject.process_period = "222"
      expect(subject.process_period).to eq(222)
    end
  end

  describe "configuration_id=" do
    it 'should set the configuration_id attribute values as integer' do
      subject.configuration_id = "222"
      expect(subject.configuration_id).to eq(222)
    end
  end

  describe 'process' do
    before :each do
      KalibroClient::Entities::Processor::Repository.
        expects(:request).
        with('process', {id: subject.id})
    end

    it 'should call the request method' do
      subject.process
    end
  end

  describe 'cancel_processing_of_repository' do
    before :each do
      KalibroClient::Entities::Processor::Repository.
        expects(:request).
        with('cancel_process', {id: subject.id})
    end

    it 'should call the request method' do
      subject.cancel_processing_of_repository
    end
  end

  describe 'all' do
    let(:project) { FactoryGirl.build(:project) }

    before :each do
      KalibroClient::Entities::Processor::Project.
        expects(:all).
        returns([project])
      KalibroClient::Entities::Processor::Repository.
        expects(:repositories_of).
        with(project.id).
        returns([subject])
    end

    it 'should list all the repositories' do
      expect(KalibroClient::Entities::Processor::Repository.all).to include(subject)
    end
  end

  # The only purpose of this test is to cover the overrided save_params method
  describe 'save' do
    subject {FactoryGirl.build(:repository)}

    before :each do
      KalibroClient::Entities::Processor::Repository.
        expects(:request).
        with('', {:repository => subject.to_hash, :project_id => 1}, :post, '').
        returns("repository" => {'id' => 1, 'kalibro_errors' => []})

      KalibroClient::Entities::Processor::Repository.any_instance.
        expects(:id=).
        with(1).
        returns(1)
    end

    it 'should make a request to save model with id and return true without errors' do
      expect(subject.save).to be(true)
      expect(subject.kalibro_errors).to be_empty
    end
  end
end
