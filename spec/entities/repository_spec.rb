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

describe KalibroGatekeeperClient::Entities::Repository do
  subject { FactoryGirl.build(:repository) }

  describe 'repository_types' do
    before :each do
      KalibroGatekeeperClient::Entities::Repository.
        expects(:request).
        with('supported_types', {}, :get).
        returns({'supported_types'=>["BAZAAR", "GIT", "MERCURIAL", "REMOTE_TARBALL", "REMOTE_ZIP"],
                 :"@xmlns:ns2"=>"http://service.kalibro.org/"})
    end

    it 'should return an array of repository types' do
      expect(KalibroGatekeeperClient::Entities::Repository.repository_types).to eq(["BAZAAR", "GIT", "MERCURIAL", "REMOTE_TARBALL", "REMOTE_ZIP"])
    end
  end

  describe 'repositories_of' do
    before :each do
      KalibroGatekeeperClient::Entities::Repository.
        expects(:request).
        with('of', {project_id: 1}).
        returns({'repositories' => [],
                 :"@xmlns:ns2"=>"http://service.kalibro.org/"})
    end

    it 'should return an array' do
      expect(KalibroGatekeeperClient::Entities::Repository.repositories_of(1)).to be_an(Array)
    end

    it 'should set the repository_id' do
      KalibroGatekeeperClient::Entities::Repository.repositories_of(1).each do |repository|
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
      KalibroGatekeeperClient::Entities::Repository.
        expects(:request).
        with('process', {id: subject.id})
    end

    it 'should call the request method' do
      subject.process
    end
  end

  describe 'cancel_processing_of_repository' do
    before :each do
      KalibroGatekeeperClient::Entities::Repository.
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
      KalibroGatekeeperClient::Entities::Project.
        expects(:all).
        returns([project])
      KalibroGatekeeperClient::Entities::Repository.
        expects(:repositories_of).
        with(project.id).
        returns([subject])
    end

    it 'should list all the repositories' do
      expect(KalibroGatekeeperClient::Entities::Repository.all).to include(subject)
    end
  end

  describe 'find' do
    context 'when the repository exists' do
      before :each do
        KalibroGatekeeperClient::Entities::Repository.
          expects(:all).
          returns([subject])
      end

      it 'should return the repository' do
        expect(KalibroGatekeeperClient::Entities::Repository.find(subject.id)).to eq(subject)
      end
    end

    context "when the repository doesn't exists" do
      before :each do
        KalibroGatekeeperClient::Entities::Repository.
          expects(:all).
          returns([FactoryGirl.build(:another_repository)])
      end

      it 'should raise a RecordNotFound error' do
        expect { KalibroGatekeeperClient::Entities::Repository.find(subject.id) }.
          to raise_error(KalibroGatekeeperClient::Errors::RecordNotFound)
      end
    end
  end

  # The only purpose of this test is to cover the overrided save_params method
  describe 'save' do
    subject {FactoryGirl.build(:repository, {id: nil})}

    before :each do
      KalibroGatekeeperClient::Entities::Repository.
        expects(:request).
        with('save', {:repository => subject.to_hash, :project_id => 1}).
        returns({'id' => 1, 'kalibro_errors' => []})

      KalibroGatekeeperClient::Entities::Repository.any_instance.
        expects(:id=).
        with(1).
        returns(1)
    end

    it 'should make a request to save model with id and return true without errors' do
      expect(subject.save).to be(true)
      expect(subject.kalibro_errors).to be_empty
    end
  end

  describe 'exists?' do
    subject {FactoryGirl.build(:repository)}

    context 'when the repository exists' do
      before :each do
        KalibroGatekeeperClient::Entities::Repository.expects(:find).with(subject.id).returns(subject)
      end

      it 'should return true' do
        expect(KalibroGatekeeperClient::Entities::Repository.exists?(subject.id)).to be_truthy
      end
    end

    context 'when the repository does not exists' do
      before :each do
        KalibroGatekeeperClient::Entities::Repository.expects(:find).with(subject.id).raises(KalibroGatekeeperClient::Errors::RecordNotFound)
      end

      it 'should return false' do
        expect(KalibroGatekeeperClient::Entities::Repository.exists?(subject.id)).to be_falsey
      end
    end
  end
end