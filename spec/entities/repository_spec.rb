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

describe KalibroEntities::Entities::Repository do
  describe 'repository_types' do
    before :each do
      KalibroEntities::Entities::Repository.
        expects(:request).
        with(:supported_repository_types).
        returns({:supported_type=>["BAZAAR", "GIT", "MERCURIAL", "REMOTE_TARBALL", "REMOTE_ZIP"],
                 :"@xmlns:ns2"=>"http://service.kalibro.org/"})
    end

    it 'should return an array of repository types' do
      KalibroEntities::Entities::Repository.repository_types.should eq(["BAZAAR", "GIT", "MERCURIAL", "REMOTE_TARBALL", "REMOTE_ZIP"])
    end
  end

  describe 'repositories_of' do
    before :each do
      KalibroEntities::Entities::Repository.
        expects(:request).
        with(:repositories_of, {:project_id => 1}).
        returns({:repository=>[],
                 :"@xmlns:ns2"=>"http://service.kalibro.org/"})
    end

    it 'should return an array' do
      KalibroEntities::Entities::Repository.repositories_of(1).should be_an(Array)
    end
  end

  describe "id=" do
    subject { FactoryGirl.build(:repository) }

    it 'should set the id attribute values' do
      subject.id = 222
      subject.id.should eq(222)
    end
  end

  describe "process_period=" do
    subject { FactoryGirl.build(:repository) }

    it 'should set the process_period attribute values' do
      subject.process_period = 222
      subject.process_period.should eq(222)
    end
  end

  describe "configuration_id=" do
    subject { FactoryGirl.build(:repository) }

    it 'should set the configuration_id attribute values' do
      subject.configuration_id = 222
      subject.configuration_id.should eq(222)
    end
  end

  describe 'process' do
    subject { FactoryGirl.build(:repository) }

    it 'should call the request method' do
      KalibroEntities::Entities::Repository.
        expects(:request).
        with(:process_repository, {:repository_id => subject.id})
      subject.process
    end
  end

  describe 'cancel_processing_of_repository' do
    subject { FactoryGirl.build(:repository) }

    it 'should call the request method' do
      KalibroEntities::Entities::Repository.
        expects(:request).
        with(:cancel_processing_of_repository, {:repository_id => subject.id})
      subject.cancel_processing_of_repository
    end
  end

  # The only purpose of this test is to cover the overrided save_params method
  describe 'save' do
    subject {FactoryGirl.build(:repository, {id: nil})}

    before :each do
      KalibroEntities::Entities::Repository.
        expects(:request).with(:save_repository, {:repository => {:send_email => 'test@test.com', :project_id => '1', :configuration_id => '1', :address => 'svn://svn.code.sf.net/p/qt-calculator/code/trunk', :type => 'SVN', :process_period => '1', :license => 'GPLv3', :description => 'A simple calculator', :name => 'QtCalculator'}, :project_id => 1}).returns({:repository_id => 1})

      KalibroEntities::Entities::Repository.any_instance.expects(:id=).with(1).returns(1)
      KalibroEntities::Entities::Repository.any_instance.expects(:id=).with(nil).returns(nil)
    end

    it 'should make a request to save model with id and return true without errors' do
      subject.save.should be(true)
      subject.kalibro_errors.should be_empty
    end
  end

  describe 'all' do
    let(:project) { FactoryGirl.build(:project) }
    let(:repository) { FactoryGirl.build(:repository)}

    before :each do
      KalibroEntities::Entities::Project.expects(:all).returns([project])
      KalibroEntities::Entities::Repository.expects(:repositories_of).with(project.id).returns([repository])
    end

    it 'should list all the repositories' do
      KalibroEntities::Entities::Repository.all.should include(repository)
    end
  end
end