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

Then(/^it should return Checkstyle and Analizo strings inside of an array$/) do
  (@base_tool_names.include?("Checkstyle") && @base_tool_names.include?("Analizo")).should be_true
end

Then(/^I should get Analizo base tool$/) do
  @result.name.should eq "Analizo"
end

Then(/^I should get an error$/) do
  @is_error.should be_true
end
