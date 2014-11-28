FactoryGirl.define  do
  factory :granularity, class: KalibroClient::Miscellaneous::Granularity do
    type :SOFTWARE

    initialize_with { KalibroClient::Miscellaneous::Granularity.new(type) }
  end
end