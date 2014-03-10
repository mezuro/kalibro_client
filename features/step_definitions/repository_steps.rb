Given(/^the given project has the following Repositories:$/) do |table|
  hash = table.hashes.first
  hash[:project_id] = @project.id
  hash[:configuration_id] = @configuration.id
  hash[:id] = nil

  @repository = FactoryGirl.create(:repository, hash)
end

When(/^I call the cancel_process method for the given repository$/) do
  @response = @repository.cancel_processing_of_repository
end

When(/^I ask for repositories from the given project$/) do
  @response = KalibroGatekeeperClient::Entities::Repository.repositories_of(@project.id)
end

When(/^I call the process method for the given repository$/) do
  @response = @repository.process
end

When(/^I list types$/) do
  @repository_types = KalibroGatekeeperClient::Entities::Repository.repository_types
end

When(/^I ask for all the repositories$/) do
  @response = KalibroGatekeeperClient::Entities::Repository.all
end

When(/^I ask to find the given repository$/) do
  @response = KalibroGatekeeperClient::Entities::Repository.find(@repository.id)
end

When(/^I ask to check if the given repository exists$/) do
  @response = KalibroGatekeeperClient::Entities::Repository.exists?(@repository.id)
end

Then(/^I should get success$/) do
  @response == true
end

Then(/^I should get a list with the given repository$/) do
  @response.should include(@repository)
end

Then(/^I should get an array of types$/) do
  @repository_types.is_a?(Array)
  @repository_types.count >= 1
end

Then(/^I should get the given repository$/) do
  @response.should eq(@repository)
end

Then(/^the response should contain the given repository$/) do
  @response.first.project_id.should eq(@project.id)
end

Then(/^the repositories should contain the project id$/) do
  @response.first.project_id.should eq(@project.id)
end
