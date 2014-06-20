Given(/^I have a reading group with name "(.*?)"$/) do |name|
  @reading_group = FactoryGirl.create(:reading_group, {id: nil, name: name})
end

When(/^I ask for all the reading groups$/) do
  @all_reading_groups = KalibroGatekeeperClient::Entities::ReadingGroup.all
end

When(/^I call the reading_group_of method for the given MetricConfiguration$/) do
  @metric_configuration_reading_group = KalibroGatekeeperClient::Entities::ReadingGroup.reading_group_of(@metric_configuration.id)
end

Then(/^I should get a list with the given reading group$/) do
  expect(@all_reading_groups).to include(@reading_group)
end

Then(/^I should get the given RedingGroup$/) do
  expect(@metric_configuration_reading_group).to eq(@reading_group)
end
