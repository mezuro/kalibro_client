When(/^I get all metric collector names$/) do
  @metric_collector_names = KalibroClient::Entities::Processor::MetricCollectorDetails.all_names
end

When(/^I search metric collector "(.+?)" by name \(strictly\)$/) do |name|
  begin
    @response = KalibroClient::Entities::Processor::MetricCollectorDetails.find_by_name!(name)
  rescue Likeno::Errors::RecordNotFound
    @is_error = true
  else
    @is_error = false
  end
end

When(/^I search metric collector "(.+)" by name$/) do |name|
  @response = KalibroClient::Entities::Processor::MetricCollectorDetails.find_by_name(name)
end

Then(/^it should return "(.+?)" string inside of an array$/) do |string|
  expect(@metric_collector_names.include?(string)).to be_truthy
end

Then(/^I should get "(.+)" metric collector$/) do |name|
  expect(@response.name).to eq(name)
end

Then(/^I should get an error$/) do
  expect(@is_error).to be_truthy
end
