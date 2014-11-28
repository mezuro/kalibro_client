FactoryGirl.define do
  factory :module_result, class: KalibroClient::Processor::ModuleResult do
    kalibro_module { FactoryGirl.build(:kalibro_module) }
    parent nil
    grade 10.0
    height 0
    metric_results { [] }

    initialize_with { KalibroClient::Processor::ModuleResult.new({parent: parent, kalibro_module: kalibro_module}) }
  end
end