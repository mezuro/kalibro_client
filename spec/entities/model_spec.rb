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

describe KalibroEntities::Entities::Model do
  describe 'new' do
    it 'should create a model from an empty hash' do
      model = KalibroEntities::Entities::Model.new {}

      model.kalibro_errors.should eq([])
    end
  end

  describe 'class_name' do
    subject { KalibroEntities::Entities::Model.new {} }

    it 'should be a String' do
      subject.class.class_name.should be_a(String)
    end

    it 'should return Model' do
      subject.class.class_name.should eq('Model')
    end
  end

  describe 'endpoint' do
    it 'should return the class_name' do
      endpoint = 'test'
      KalibroEntities::Entities::Model.expects(:class_name).returns(endpoint)

      KalibroEntities::Entities::Model.endpoint.should eq(endpoint)
    end
  end

  describe 'client' do
    it 'returns a Savon::Client' do
      KalibroEntities::Entities::Model.client('Model').should be_a(Savon::Client)
    end
  end

  describe 'request' do
    before :each do
      @fixture = File.read("spec/savon/fixtures/project/does_not_exists.xml")
      @client = mock('client')
    end

    it 'should successfully get the Kalibro version' do
      @client.expects(:call).with(:project_exists, message: {project_id: 1}).returns(mock_savon_response(@fixture))
      KalibroEntities::Entities::Model.expects(:client).with(any_parameters).returns(@client)

      KalibroEntities::Entities::Model.request(:project_exists, {project_id: 1})[:exists].should eq(false)
    end
  end

  describe 'to_hash' do
    it 'should return an empty hash' do
      subject.to_hash.should be_empty
    end
  end

  describe 'to_object' do
    it 'should return an Object with an empty hash' do
      KalibroEntities::Entities::Model.to_object({}).should eq(KalibroEntities::Entities::Model.new)
    end

    it "should remain an object if it isn't a Hash" do
      KalibroEntities::Entities::Model.to_object(Object.new).should be_an(Object)
    end
  end

  describe 'to_objects_array' do
    it 'should convert [{}] to [Model]' do
      KalibroEntities::Entities::Model.to_objects_array({}).should eq([KalibroEntities::Entities::Model.new]) 
    end

    it 'should remain an array if it already is one' do
      object = Object.new
      KalibroEntities::Entities::Model.to_objects_array([object]).should eq([object]) 
    end
  end

  describe 'save' do
    before :each do
      KalibroEntities::Entities::Model.expects(:request).with(:save_model, {:model=>{}}).returns({:model_id => 42})
    end

    context "when it doesn't have the method id=" do
      it 'should make a request to save model with id returning false and an error' do
        subject.save.should be(false)
        subject.kalibro_errors[0].should be_a(NoMethodError)
      end
    end

    context 'when it has the method id=' do
      before :each do
        KalibroEntities::Entities::Model.any_instance.expects(:id=).with(42).returns(42)
      end

      it 'should make a request to save model with id and return true without errors' do
        subject.save.should be(true)
        subject.kalibro_errors.should be_empty
      end
    end
  end

  describe 'create' do
    before :each do
      @model = KalibroEntities::Entities::Model.new
      @model.expects(:save)
      KalibroEntities::Entities::Model.expects(:new).with({}).returns(@model)
    end

    it 'should instantiate and save the model' do
      (KalibroEntities::Entities::Model.create {}).should eq(@model)
    end
  end

  describe '==' do
    context 'comparing objects from different classes' do
      it 'should return false' do
        subject.should_not eq(Object.new)
      end
    end

    context 'with two models with different attribute values' do
      before :each do
        subject.expects(:variable_names).returns(["answer"])
        subject.expects(:send).with("answer").returns(42)

        @another_model = KalibroEntities::Entities::Model.new
        @another_model.expects(:send).with("answer").returns(41)
      end 

      it 'should return false' do
        subject.should_not eq(@another_model)
      end
    end

    context 'with two empty models' do
      it 'should return true' do
        subject.should eq(KalibroEntities::Entities::Model.new)
      end
    end
  end

  describe 'exists?' do
    context 'with an inexistent id' do
      before :each do
        KalibroEntities::Entities::Model.expects(:request).with(:model_exists,{:model_id=>0}).returns({:exists => false})
      end

      it 'should return false' do
        KalibroEntities::Entities::Model.exists?(0).should eq(false)
      end
    end

    context 'with an existent id' do
      before :each do
        KalibroEntities::Entities::Model.expects(:request).with(:model_exists,{:model_id=>42}).returns({:exists => true})
      end

      it 'should return false' do
        KalibroEntities::Entities::Model.exists?(42).should eq(true)
      end
    end
  end

  describe 'find' do
    context 'with an inexistent id' do
      before :each do
        KalibroEntities::Entities::Model.expects(:exists?).with(0).returns(false)
      end

      it 'should raise a RecordNotFound error' do
        expect { KalibroEntities::Entities::Model.find(0)}.to raise_error(KalibroEntities::Errors::RecordNotFound)
      end
    end

    context 'with an existent id' do
      before :each do
        KalibroEntities::Entities::Model.expects(:exists?).with(42).returns(true)
        KalibroEntities::Entities::Model.expects(:request).with(:get_model,{:model_id => 42}).returns({:model => {}})
      end

      it 'should return an empty model' do
        KalibroEntities::Entities::Model.find(42).should eq(subject)
      end
    end
  end

  describe 'destroy' do
    context 'when it gets successfully destroyed' do
      before :each do
        subject.expects(:id).at_least_once.returns(42)
        KalibroEntities::Entities::Model.expects(:request).with(:delete_model,{:model_id => subject.id})
      end

      it 'should remain with the errors array empty' do
        subject.destroy
        subject.kalibro_errors.should be_empty
      end
    end

    context 'when the destruction fails' do
      before :each do
        subject.expects(:id).at_least_once.returns(42)
        KalibroEntities::Entities::Model.expects(:request).with(:delete_model,{:model_id => subject.id}).raises(Exception.new)
      end

      it "should have an exception inside it's errors" do
        subject.destroy

        subject.kalibro_errors[0].should be_an(Exception)
      end
    end
  end

  describe 'create_objects_array_from_hash' do
    context 'with nil' do
      it 'should return an empty array' do
        KalibroEntities::Entities::Model.create_objects_array_from_hash(nil).should eq([])
      end
    end

    context 'with a Hash' do
      it 'should return the correspondent object to the given hash inside of an Array' do
        KalibroEntities::Entities::Model.create_objects_array_from_hash({}).should eq([subject])
      end
    end
  end
end