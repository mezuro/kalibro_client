FactoryGirl.define do
  factory :kalibro_module, class: KalibroClient::Processor::KalibroModule do
    id 51
    granularity { FactoryGirl.build(:granularity) }
    name { ['home', 'user', 'project'] }
  end
end