When(/^I get all base tool names$/) do
  @base_tool_names = KalibroGatekeeperClient::Entities::BaseTool.all_names
end

When(/^I search base tool Analizo by name$/) do
  @result = KalibroGatekeeperClient::Entities::BaseTool.find_by_name("Analizo")
end

When(/^I search base tool Avalio by name$/) do
  @is_error = false
  begin
  	KalibroGatekeeperClient::Entities::BaseTool.find_by_name("Avalio")
	rescue KalibroGatekeeperClient::Errors::RecordNotFound
  	@is_error = true
  end
end

Then(/^it should return Analizo string inside of an array$/) do
  expect(@base_tool_names.include?("Analizo")).to be_truthy
end

Then(/^I should get Analizo base tool$/) do
  expect(@result.name).to eq("Analizo")
end

Then(/^I should get an error$/) do
  expect(@is_error).to be_truthy
end
