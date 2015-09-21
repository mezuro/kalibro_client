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

describe KalibroClient::Entities::Base do
  subject { FactoryGirl.build(:model) }

  describe 'new' do
    it 'should create a model from an empty hash' do
      subject = KalibroClient::Entities::Base.new {}
      expect(subject.kalibro_errors).to eq([])
    end
  end

  describe 'entity_name' do
    it 'should be a String' do
      expect(subject.class.entity_name).to be_a(String)
    end

    it 'should return Base' do
      expect(subject.class.entity_name).to eq('base')
    end
  end

  describe 'endpoint' do
    it 'should return the entity_name' do
      endpoint = 'tests'
      KalibroClient::Entities::Base.expects(:entity_name).returns(endpoint)
      expect(KalibroClient::Entities::Base.endpoint).to eq(endpoint)
    end
  end

  describe 'client' do
    it 'returns a Faraday::Connection' do
      expect { KalibroClient::Entities::Base.client }.to raise_error(NotImplementedError)
    end
  end

  describe 'request' do
    let(:fixture) { File.read("spec/savon/fixtures/project/does_not_exists.xml") }
    let(:client) { mock('client') }
    let(:response) { mock('response') }
    let(:request) { mock('request') }
    let(:options) { mock('options') }

    before :each do
      options.expects(:timeout=)
      options.expects(:open_timeout=)
      request.expects(:url).with('/bases/exists')
      request.expects(:body=).with({id: 1})
      request.expects(:options).twice.returns(options)
    end

    context 'for the KalibroClient::Entities module' do
      it 'should successfully get the Kalibro version' do
        pending
        response.expects(:body).returns({exists: false})
        client.expects(:post).yields(request).returns(response)
        KalibroClient::Entities::Base.expects(:client).with(any_parameters).returns(client)
        expect(KalibroClient::Entities::Base.request('exists', {id: 1})[:exists]).to eq(false)
      end
    end

    context 'with a children class from outside' do
      class Child < KalibroClient::Entities::Base; end

      it 'should successfully get the Kalibro version' do
        pending
        response.expects(:body).returns({exists: false})
        client.expects(:post).yields(request).returns(response)
        Child.expects(:client).with(any_parameters).returns(client)
        expect(Child.request('exists', {id: 1})[:exists]).to eq(false)
      end
    end
  end

  describe 'to_hash' do
    it 'should return an empty hash' do
      expect(subject.to_hash).to be_empty
    end
  end

  describe 'to_object' do
    it 'should return an Object with an empty hash' do
      expect(KalibroClient::Entities::Base.to_object({})).to eq(FactoryGirl.build(:model))
    end

    it "should remain an object if it isn't a Hash" do
      expect(KalibroClient::Entities::Base.to_object(Object.new)).to be_an(Object)
    end
  end

  describe 'to_objects_array' do
    it 'should convert [{}] to [Model]' do
      expect(KalibroClient::Entities::Base.to_objects_array({})).to eq([FactoryGirl.build(:model)])
    end

    it 'should remain an array if it already is one' do
      object = Object.new
      expect(KalibroClient::Entities::Base.to_objects_array([object])).to eq([object])
    end
  end

  describe 'save' do
    context "when it is not persisted" do
      context "when it doesn't have the method id=" do
        before :each do
          KalibroClient::Entities::Base.
            expects(:request).
            with('', {base: {}}, :post, '').returns({"base" => {'id' => 42, 'kalibro_errors' => []}})
        end

        it 'should make a request to save model with id returning false and an error' do
          expect(subject.save).to be(false)
          expect(subject.kalibro_errors[0]).to be_a(NoMethodError)
        end
      end

      context 'when it has the method id=' do
        before :each do
          KalibroClient::Entities::Base.
            expects(:request).
            with('', {base: {}}, :post, '').returns({"base" => {'id' => 42, 'kalibro_errors' => []}})
          KalibroClient::Entities::Base.any_instance.expects(:id=).with(42).returns(42)
        end

        it 'should make a request to save model with id and return true without errors' do
          expect(subject.save).to be(true)
          expect(subject.kalibro_errors).to be_empty
        end
      end

      context "when it returns with a kalibro processor error" do
        before :each do
          KalibroClient::Entities::Base.
            expects(:request).
            with('', {base: {}}, :post, '').returns({"errors" => ["Name has already been taken"]})
        end

        it 'should make a request to save model returning false and a kalibro error' do
          expect(subject.save).to be(false)
          expect(subject.kalibro_errors[0]).to eq("Name has already been taken")
        end
      end
    end

    context 'when it is persisted' do
      before :each do
        subject.persisted = true
      end

      it 'is expected to call the update method'  do
        subject.expects(:update)

        subject.save
      end
    end
  end

  describe 'update' do
    let!(:id) { 42 }

    context 'with valid parameters' do
      before :each do
        KalibroClient::Entities::Base.
              expects(:request).
              with(':id', {base: {}, id: id}, :put, '').returns({"base" => {'id' => id, 'kalibro_errors' => []}})
        subject.expects(:id).returns(id)
        subject.expects(:to_hash).returns({})
      end

      it 'is expect to return true' do
        expect(subject.update).to be_truthy
      end
    end

    context 'with invalid parameters' do
      before :each do
        KalibroClient::Entities::Base.
              expects(:request).
              with(':id', {base: {}, id: id}, :put, '').returns({"errors" => ["Error"]})
        subject.expects(:id).returns(id)
        subject.expects(:to_hash).returns({})
      end

      it 'is expect to return false' do
        expect(subject.update).to be_falsey
      end

      it 'is expect fill the errors' do
        subject.update

        expect(subject.kalibro_errors).to_not be_empty
      end
    end
  end

  describe 'save!' do
    subject { FactoryGirl.build(:project) }

    it 'should call save and not raise when saving works' do
      subject.expects(:save).returns(true)
      expect { subject.save! }.not_to raise_error
    end

    it 'should call save and raise RecordInvalid when saving fails' do
      subject.expects(:kalibro_errors).returns(['test1', 'test2'])
      subject.expects(:save).returns(false)

      expect { subject.save! }.to raise_error { |error|
        expect(error).to be_a(KalibroClient::Errors::RecordInvalid)
        expect(error.record).to be(subject)
        expect(error.message).to eq('Record invalid: test1, test2')
      }
    end
  end

  describe 'create' do
    before :each do
      subject.expects(:save)
      KalibroClient::Entities::Base.
        expects(:new).
        with({}).
        returns(subject)
    end

    it 'should instantiate and save the model' do
      expect(KalibroClient::Entities::Base.create {}).to eq(subject)
    end
  end

  describe '==' do
    context 'comparing objects from different classes' do
      it 'should return false' do
        expect(subject).not_to eq(Object.new)
      end
    end

    context 'with two models with different attribute values' do
      let(:another_model) { FactoryGirl.build(:model) }
      before :each do
        subject.expects(:variable_names).returns(["answer"])
        subject.expects(:send).with("answer").returns(42)
        another_model.expects(:send).with("answer").returns(41)
      end

      it 'should return false' do
        expect(subject).not_to eq(another_model)
      end
    end

    context 'with two empty models' do
      it 'should return true' do
        expect(subject).to eq(FactoryGirl.build(:model))
      end
    end
  end

  describe 'exists?' do
    context 'with an inexistent id' do
      before :each do
        KalibroClient::Entities::Base.
          expects(:request).
          with(':id/exists', {id: 0}, :get).
          returns({'exists' => false})
      end

      it 'should return false' do
        expect(KalibroClient::Entities::Base.exists?(0)).to eq(false)
      end
    end

    context 'with an existent id' do
      before :each do
        KalibroClient::Entities::Base.
          expects(:request).
          with(':id/exists', {id: 42}, :get).
          returns({'exists' => true})
      end

      it 'should return false' do
        expect(KalibroClient::Entities::Base.exists?(42)).to eq(true)
      end
    end
  end

  describe 'find' do
    context 'with an inexistent id' do
      before :each do
        KalibroClient::Entities::Base.expects(:exists?).with(0).returns(false)
      end

      it 'should raise a RecordNotFound error' do
        expect { KalibroClient::Entities::Base.find(0)}.to raise_error(KalibroClient::Errors::RecordNotFound)
      end
    end

    context 'with an existent id' do
      before :each do
        KalibroClient::Entities::Base.
          expects(:exists?).with(42).
          returns(true)
        KalibroClient::Entities::Base.
          expects(:request).
          with(':id',{id: 42}, :get).returns("base" => {})
      end

      it 'should return an empty model' do
        expect(KalibroClient::Entities::Base.find(42)).to eq(subject)
      end
    end
  end

  describe 'destroy' do
    context 'when it gets successfully destroyed' do
      before :each do
        subject.expects(:id).at_least_once.returns(42)
        KalibroClient::Entities::Base.expects(:request).with(':id',{id: subject.id}, :delete, '').returns({})
      end

      it 'should remain with the errors array empty and not persisted' do
        subject.destroy
        expect(subject.kalibro_errors).to be_empty
        expect(subject.persisted?).to be_falsey
      end
    end

    context 'when the destruction fails' do
      context 'raising a exception' do
        before :each do
          subject.expects(:id).at_least_once.returns(42)
          KalibroClient::Entities::Base.expects(:request).with(':id',{id: subject.id}, :delete, '').raises(Exception.new)
        end

        it "should have an exception inside it's errors" do
          subject.destroy

          expect(subject.kalibro_errors[0]).to be_an(Exception)
        end
      end

      context 'returning kalibro_errors' do
        before :each do
          subject.expects(:id).at_least_once.returns(42)
          KalibroClient::Entities::Base.expects(:request).with(':id',{id: subject.id}, :delete, '').returns({'errors' => ['Error']})
        end

        it 'is expected to return false' do
          expect(subject.destroy).to be_falsey
        end
      end
    end
  end

  describe 'create_objects_array_from_hash' do
    context 'with nil' do
      it 'should return an empty array' do
        expect(KalibroClient::Entities::Base.create_objects_array_from_hash("bases" => [])).to eq([])
      end
    end

    context 'with a Hash' do
      it 'should return the correspondent object to the given hash inside of an Array' do
        expect(KalibroClient::Entities::Base.create_objects_array_from_hash("bases" => {})).to eq([subject])
      end
    end
  end

  describe 'is_valid?' do
    context 'with a global var' do
      it 'should return false' do
        expect(KalibroClient::Entities::Base.is_valid?('@test')).to be_falsey
      end
    end

    context 'with the attributes var' do
      it 'should return false' do
        expect(KalibroClient::Entities::Base.is_valid?(:attributes!)).to be_falsey
      end
    end

    context 'with a xsi var' do
      it 'should return false' do
        expect(KalibroClient::Entities::Base.is_valid?('test_xsi')).to be_falsey
      end
    end

    context 'with a valid var' do
      it 'should return true' do
        expect(KalibroClient::Entities::Base.is_valid?('test')).to be_truthy
      end
    end
  end
end
