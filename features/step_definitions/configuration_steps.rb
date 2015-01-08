Given(/^I have a configuration with name "(.*?)"$/) do |name|
  @configuration = FactoryGirl.create(:configuration, {name: name, id: nil})
end

When(/^I get all the configurations$/) do
  @all_configurations = KalibroClient::Entities::Configuration.all
end

When(/^I create the configuration with name "(.*?)"$/) do |name|
  @configuration = FactoryGirl.create(:configuration, {name: name, id: nil})
end

Then(/^I should get a list with the given configuration$/) do
  expect(@all_configurations.include?(@configuration)).to be_truthy
end

Then(/^the configuration should exist$/) do
  expect(KalibroClient::Entities::Configuration.exists?(@configuration.id)).to be_truthy
end
