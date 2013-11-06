Given(/^I have a metric configuration within the given configuration$/) do
  @metric_configuration = FactoryGirl.create(:metric_configuration,
                    {id: nil,
                     reading_group_id: @reading_group.id,
                     configuration_id: @configuration.id})
end

Given(/^I have a metric configuration within the given configuration with the given metric$/) do
  @metric_configuration = FactoryGirl.create(:metric_configuration,
                    {id: nil,
                     metric: @metric,
                     reading_group_id: @reading_group.id,
                     configuration_id: @configuration.id})
end

Given(/^I have a loc configuration within the given configuration$/) do
  @metric_configuration = FactoryGirl.create(:metric_configuration,
                    {id: nil,
                     metric: FactoryGirl.create(:loc),
                     reading_group_id: @reading_group.id,
                     configuration_id: @configuration.id})
end

When(/^I search a metric configuration with the same id of the given metric configuration$/) do
  @found_metric_configuration = KalibroGem::Entities::MetricConfiguration.find(@metric_configuration.id)
end

When(/^I search an inexistent metric configuration$/) do
  @is_error = false
  inexistent_id = rand(Time.now.to_i)
  begin
  	KalibroGem::Entities::MetricConfiguration.find(inexistent_id)
  rescue KalibroGem::Errors::RecordNotFound
  	@is_error = true
  end
end

When(/^I request all metric configurations of the given configuration$/) do
  @metric_configurations = KalibroGem::Entities::MetricConfiguration.metric_configurations_of(@configuration.id)
end

Then(/^it should return the same metric configuration as the given one$/) do
  @found_metric_configuration == @metric_configuration
end

Then(/^I should get a list of its metric configurations$/) do
  @metric_configurations == [@metric_configuration]
end

Then(/^I should get an empty list of metric configurations$/) do
  @metric_configurations == []
end
