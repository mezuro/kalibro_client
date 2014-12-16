FactoryGirl.define do
  factory :reading, class: KalibroClient::Configurations::Reading do
    id 3
    label "Reading"
    grade 1.5
    color "FF0000"
    reading_group { FactoryGirl.build(:reading_group) }
  end
end
