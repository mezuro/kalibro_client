Given(/^I have a configuration with name "(.*?)"$/) do |name|
  @configuration = FactoryGirl.create(:configuration, {name: name, id: nil})
end

When(/^I get all the configurations$/) do
  @all_configurations = KalibroEntities::Entities::Configuration.all
end

Then(/^it should return the created configuration inside of an array$/) do
  @all_configurations.include?(@configuration)
end
