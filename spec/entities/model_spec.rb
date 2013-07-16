require 'spec_helper'

describe KalibroEntities::Model do
  describe 'new' do
    it 'should create a model from an empty hash' do
      model = KalibroEntities::Model.new {}

      model.errors.should eq([])
    end
  end
end