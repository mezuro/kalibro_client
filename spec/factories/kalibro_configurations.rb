FactoryGirl.define do
  factory :kalibro_configuration, class: KalibroClient::Configurations::KalibroConfiguration do
    id 1
    name "My Configuration"
    description "Sample description"
  end
end
