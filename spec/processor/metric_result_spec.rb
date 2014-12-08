require 'kalibro_client'

describe KalibroClient::Processor::MetricResult, :type => :model do
  pending do 
    describe 'methods' do
      describe 'metric_configuration' do
        context 'with an available metric result' do
          let(:metric_configuration_attributes) { FactoryGirl.attributes_for(:metric_configuration) }
          let(:metric_configuration) { FactoryGirl.build(:metric_configuration) }
          let(:metric_result) { FactoryGirl.build(:metric_result) }

          before :each do
            KalibroClient::Processor::MetricResult.expects(:get).with(:metric_configuration).returns({:metric_configuration => metric_configuration_attributes}.to_json)
            KalibroClient::Configurations::MetricConfiguration.expects(:new).returns(metric_configuration)
          end

          it 'should return the metric configuration' do
            expect(metric_result.metric_configuration).to eq(metric_configuration)
          end
        end
      end
    end
  end
end
