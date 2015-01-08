require 'spec_helper'

describe KalibroClient::Entities::Miscellaneous::NativeMetric, :type => :model do
  describe 'methods' do
    describe 'initialize' do
      context 'with valid attributes' do
        name = "Sample name"
        code = "sample_code"
        scope = KalibroClient::Entities::Miscellaneous::Granularity.new(:SOFTWARE)
        languages = [:C, :CPP, :JAVA]
        native_metric = KalibroClient::Entities::Miscellaneous::NativeMetric.new(name, code, scope, languages)

        it 'should return an instance of NativeMetric' do
          expect(native_metric).to be_a(KalibroClient::Entities::Miscellaneous::NativeMetric)
        end
      end
    end
  end
end
