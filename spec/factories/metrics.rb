FactoryGirl.define  do
  factory :metric, class: KalibroClient::Processor::Metric do
    compound false
    name "Total Abstract Classes"
    code "total_abstract_classes"
    scope { :SOFTWARE }
    description "Total Abstract Classes"

    initialize_with { KalibroClient::Processor::Metric.new(compound, name, code, scope, description) }
  end
end
