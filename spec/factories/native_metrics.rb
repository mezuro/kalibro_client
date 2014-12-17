FactoryGirl.define  do
  factory :native_metric, class: KalibroClient::Processor::NativeMetric do
    name "Total Abstract Classes"
    code "total_abstract_classes"
    scope { :SOFTWARE }
    description "Total Abstract Classes"
    languages { [:C] }

    initialize_with { KalibroClient::Processor::NativeMetric.new(name, code, scope, description, languages) }
  end
end
