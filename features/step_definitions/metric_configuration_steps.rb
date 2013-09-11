Given(/^I have a metric configuration within the given configuration$/) do
  @metric_configuration = FactoryGirl.create(:metric_configuration, 
                    {id: nil,
                     metric: FactoryGirl.create(:metric),
                     reading_group_id: FactoryGirl.create(:reading_group).id,
                     configuration_id: @configuration.id})
end

When(/^I search a metric configuration with the same id of the given metric configuration$/) do
  @found_metric_configuration = KalibroEntities::Entities::MetricConfiguration.find(@metric_configuration.id)
end

Then(/^it should return the same metric configuration as the given one$/) do
  @found_metric_configuration == @metric_configuration
end
