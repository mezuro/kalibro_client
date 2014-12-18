require 'spec_helper'

describe KalibroClient::Miscellaneous::NativeMetric, :type => :model do
  describe 'methods' do
    describe 'initialize' do
      context 'with valid attributes' do
        name = "Sample name"
        code = "sample_code"
        scope = KalibroClient::Miscellaneous::Granularity.new(:SOFTWARE)
        languages = [:C, :CPP, :JAVA]
        native_metric = KalibroClient::Miscellaneous::NativeMetric.new(name, code, scope, languages)

        it 'should return an instance of NativeMetric' do
          expect(native_metric).to be_a(KalibroClient::Miscellaneous::NativeMetric)
        end
      end
    end
  end
end