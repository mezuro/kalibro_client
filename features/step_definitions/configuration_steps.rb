Given(/^I have a configuration with name "(.*?)"$/) do |name|
  @configuration = FactoryGirl.create(:configuration, {name: name})
end

When(/^I get all the configurations$/) do
  @all_configurations = KalibroClient::Entities::Configurations::KalibroConfiguration.all
end

When(/^I create the configuration with name "(.*?)"$/) do |name|
  @configuration = FactoryGirl.create(:configuration, {name: name})
end

Then(/^I should get a list with the given configuration$/) do
  expect(@all_configurations.include?(@configuration)).to be_truthy
end

Then(/^the configuration should exist$/) do
  expect(KalibroClient::Entities::Configurations::KalibroConfiguration.exists?(@configuration.id)).to be_truthy
end

When(/^I destroy the configuration$/) do
  @configuration.destroy
end

Then(/^the configuration should no longer exist$/) do
  expect(KalibroClient::Entities::Configurations::KalibroConfiguration.exists?(@configuration.id)).to be_falsey
end

Given(/^the configuration has a metric configuration$/) do
  @metric_configuration = FactoryGirl.create(:metric_configuration, kalibro_configuration_id: @configuration.id)
end

When(/^I list all the metric configurations of the configuration$/) do
  @metric_configurations = @configuration.metric_configurations
end

Then(/^I should get a list with the given metric configuration$/) do
  expect(@metric_configurations.include?(@metric_configuration)).to be_truthy
end

