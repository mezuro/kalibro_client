require 'spec_helper'

describe KalibroClient::Entities::Miscellaneous::HotspotMetric, :type => :model do
  describe 'methods' do
    describe 'initialize' do
      context 'with valid attributes' do
        let(:name){ "Sample name"}
        let(:code){ "sample_code" }
        let(:languages){  [:RUBY] }
        let(:metric_collector_name){ "MetricFU" }
        let(:hotspot_metric){ KalibroClient::Entities::Miscellaneous::HotspotMetric.new(name, code, languages, metric_collector_name) }

        it 'is expected to return an instance of HotspotMetric' do
          expect(hotspot_metric).to be_a(KalibroClient::Entities::Miscellaneous::HotspotMetric)
        end

        it 'is expected to have SOFTWARE as the default scope' do
          expect(hotspot_metric.scope).to eq(KalibroClient::Entities::Miscellaneous::Granularity.new(:SOFTWARE))
        end

        it 'is expected to have HotspotMetricSnapshot type' do
          expect(hotspot_metric.type).to eq("HotspotMetricSnapshot")
        end
      end
    end
  end
end
