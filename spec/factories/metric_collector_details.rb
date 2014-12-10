FactoryGirl.define do
  factory :metric_collector_details, class: KalibroClient::Processor::MetricCollector do
    name "Metric collector name"
    description "Metric collector description"
    supported_metrics { { "total_abstract_classes" => FactoryGirl.build(:metric) } }

    initialize_with { KalibroClient::Processor::MetricCollector.new({"name" => name, "description" => description, "supported_metrics" => supported_metrics}) }
  end
end
