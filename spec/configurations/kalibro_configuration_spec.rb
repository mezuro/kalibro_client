require 'kalibro_client'
require 'json'

describe KalibroClient::Configurations::KalibroConfiguration, :type => :model do
  describe 'methods' do
    describe 'metric_configurations' do
      it 'is expected to make a get request' do
        subject.expects(:get).with(:metric_configurations).returns([])

        subject.metric_configurations
      end
    end
  end
end