Given(/^I have a configuration with name "(.*?)"$/) do |name|
  @configuration = FactoryGirl.create(:configuration, {name: name, id: nil})
end

When(/^I get all the configurations$/) do
  @all_configurations = KalibroGatekeeperClient::Entities::Configuration.all
end

Then(/^I should get a list with the given configuration$/) do
  @all_configurations.include?(@configuration).should be_true
end

When(/^I create the configuration with name "(.*?)"$/) do |name|
  @configuration = FactoryGirl.create(:configuration, {name: name, id: nil})
end

Then(/^the configuration should exist$/) do
  KalibroGatekeeperClient::Entities::Configuration.exists?(@configuration.id).should be_true
end
