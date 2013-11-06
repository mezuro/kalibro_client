Given(/^I have a configuration with name "(.*?)"$/) do |name|
  @configuration = FactoryGirl.create(:configuration, {name: name, id: nil})
end

When(/^I get all the configurations$/) do
  @all_configurations = KalibroGem::Entities::Configuration.all
end

Then(/^I should get a list with the given configuration$/) do
  @all_configurations.include?(@configuration)
end
