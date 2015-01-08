require 'spec_helper'

describe KalibroClient::Entities::Miscellaneous::Metric, :type => :model do
  describe 'methods' do
    describe 'initialize' do
      it 'should return an instance of Metric' do
        compound = true
        name = "Sample name"
        code = "sample_code"
        scope = KalibroClient::Entities::Miscellaneous::Granularity.new(:SOFTWARE)
        expect(KalibroClient::Entities::Miscellaneous::Metric.new(compound, name, code, scope)).to be_a(KalibroClient::Entities::Miscellaneous::Metric)
      end
    end
  end
end
