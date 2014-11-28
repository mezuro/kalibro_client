FactoryGirl.define do
  factory :metric_result, class: KalibroClient::Processor::MetricResult do
    metric_configuration { FactoryGirl.build(:metric_configuration) }
    value nil
    metric { FactoryGirl.build(:metric) }

    trait :with_value do
      value 2.0
    end

    factory :metric_result_with_value, traits: [:with_value]

    initialize_with { KalibroClient::Processor::MetricResult.new() }
  end
end
