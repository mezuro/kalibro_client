FactoryGirl.define do
  factory :reading_group, class: KalibroClient::Configurations::ReadingGroup do
    id 7
    name "My reading group"
    description "My reading group description"
  end
end
