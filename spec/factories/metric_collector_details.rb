FactoryGirl.define do
  factory :metric_collector_details, class: KalibroClient::Processor::MetricCollector do
    name "Metric collector name"
    description "Metric collector description"
    supported_metrics { [FactoryGirl.build(:metric)] }
  end
end
