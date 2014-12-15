FactoryGirl.define do
  factory :reading, class: KalibroClient::Configurations::Reading do
    id 3
    label "Reading"
    grade 1.5
    color "FF0000"
    reading_group_id { FactoryGirl.build(:reading_group).id }
  end
end
