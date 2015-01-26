Given(/^I have a metric configuration within the given kalibro configuration$/) do
  @metric_configuration = FactoryGirl.create(:metric_configuration,
                                             {reading_group_id: @reading_group.id,
                                              kalibro_configuration_id: @kalibro_configuration.id})
end

Given(/^I have a metric configuration within the given kalibro configuration with the given metric$/) do
  @metric_configuration = FactoryGirl.create(:metric_configuration,
                                             {metric: @metric,
                                              reading_group_id: @reading_group.id,
                                              kalibro_configuration_id: @kalibro_configuration.id})
end

Given(/^I have a loc configuration within the given kalibro configuration$/) do
  @metric_configuration = FactoryGirl.create(:metric_configuration,
                                             {metric: FactoryGirl.build(:loc),
                                              reading_group_id: @reading_group.id,
                                              kalibro_configuration_id: @kalibro_configuration.id})
end

When(/^I search a metric configuration with the same id of the given metric configuration$/) do
  @found_metric_configuration = KalibroClient::Entities::Configurations::MetricConfiguration.find(@metric_configuration.id)
end

When(/^I search an inexistent metric configuration$/) do
  @is_error = false
  inexistent_id = rand(Time.now.to_i)
  begin
    KalibroClient::Entities::Configurations::MetricConfiguration.find(inexistent_id)
  rescue KalibroClient::Errors::RecordNotFound
    @is_error = true
  end
end

When(/^I request all metric configurations of the given kalibro configuration$/) do
  @metric_configurations = KalibroClient::Entities::Configurations::MetricConfiguration.metric_configurations_of(@kalibro_configuration.id)
end

Then(/^it should return the same metric configuration as the given one$/) do
  expect(@found_metric_configuration).to eq(@metric_configuration)
end

Then(/^I should get a list of its metric configurations$/) do
  expect(@metric_configurations).to eq([@metric_configuration])
end

Then(/^I should get an empty list of metric configurations$/) do
  expect(@metric_configurations).to eq([])
end

When(/^I destroy the metric configuration$/) do
  @metric_configuration.destroy
end

Then(/^the metric configuration should no longer exist$/) do
  expect { KalibroClient::Entities::Configurations::MetricConfiguration.find(@metric_configuration.id) }.to raise_error(KalibroClient::Errors::RecordNotFound)
end

Then(/^the metric configuration should exist$/) do
  expect(KalibroClient::Entities::Configurations::MetricConfiguration.find(@metric_configuration.id)).to eq(@metric_configuration)
end
