FactoryGirl.define  do
  factory :native_metric, class: KalibroClient::Miscellaneous::NativeMetric do
    name "Total Abstract Classes"
    code "total_abstract_classes"
    scope { :SOFTWARE }
    description "Total Abstract Classes"
    languages { [:C] }

    initialize_with { KalibroClient::Miscellaneous::NativeMetric.new(name, code, scope, languages) }
  end
end
