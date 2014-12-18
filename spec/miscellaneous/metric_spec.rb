require 'spec_helper'

describe KalibroClient::Miscellaneous::Metric, :type => :model do
  describe 'methods' do
    describe 'initialize' do
      it 'should return an instance of Metric' do
        compound = true
        name = "Sample name"
        code = "sample_code"
        scope = KalibroClient::Miscellaneous::Granularity.new(:SOFTWARE)
        expect(KalibroClient::Miscellaneous::Metric.new(compound, name, code, scope)).to be_a(KalibroClient::Miscellaneous::Metric)
      end
    end
  end
end