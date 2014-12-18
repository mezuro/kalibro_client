require 'spec_helper'

describe KalibroClient::Miscellaneous::CompoundMetric, :type => :model do
  describe 'methods' do
    describe 'initialize' do
      context 'with valid attributes' do
        name = "Sample name"
        code = "sample_code"
        scope = KalibroClient::Miscellaneous::Granularity.new(:SOFTWARE)
        script = "return 0;"
        compound_metric = KalibroClient::Miscellaneous::CompoundMetric.new(name, code, scope, script)

        it 'should return an instance of CompoundMetric' do
          expect(compound_metric).to be_a(KalibroClient::Miscellaneous::CompoundMetric)
        end
      end
    end
  end
end