When(/^I get all metric collector names$/) do
  @metric_collector_names = KalibroGatekeeperClient::Entities::MetricCollector.all_names
end

When(/^I search metric collector Analizo by name$/) do
  @result = KalibroGatekeeperClient::Entities::MetricCollector.find_by_name("Analizo")
end

When(/^I search metric collector Avalio by name$/) do
  @is_error = false
  begin
  	KalibroGatekeeperClient::Entities::MetricCollector.find_by_name("Avalio")
	rescue KalibroGatekeeperClient::Errors::RecordNotFound
  	@is_error = true
  end
end

Then(/^it should return Analizo string inside of an array$/) do
  expect(@metric_collector_names.include?("Analizo")).to be_truthy
end

Then(/^I should get Analizo metric collector$/) do
  expect(@result.name).to eq("Analizo")
end

Then(/^I should get an error$/) do
  expect(@is_error).to be_truthy
end
