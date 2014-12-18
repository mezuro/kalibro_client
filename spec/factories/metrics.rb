FactoryGirl.define  do
  factory :metric, class: KalibroClient::Miscellaneous::Metric do
    compound false
    name "Total Abstract Classes"
    code "total_abstract_classes"
    scope { :SOFTWARE }
    description "Total Abstract Classes"

    initialize_with { KalibroClient::Miscellaneous::Metric.new(compound, name, code, scope) }
  end
end
