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
  @response = KalibroClient::Entities::Repository.repositories_of(@project.id)
end

When(/^I call the process method for the given repository$/) do
  @response = @repository.process
end

When(/^I list types$/) do
  @repository_types = KalibroClient::Entities::Repository.repository_types
end

When(/^I ask for all the repositories$/) do
  @response = KalibroClient::Entities::Repository.all
end

When(/^I ask to find the given repository$/) do
  @response = KalibroClient::Entities::Repository.find(@repository.id)
end

When(/^I ask to check if the given repository exists$/) do
  @response = KalibroClient::Entities::Repository.exists?(@repository.id)
end

Then(/^I should get success$/) do
  expect(@response).to be_truthy
end

Then(/^I should get a list with the given repository$/) do
  expect(@response).to include(@repository)
end

Then(/^I should get an array of types$/) do
  expect(@repository_types).to be_a(Array)
  expect(@repository_types.count >= 1).to be_truthy
  expect(@repository_types).to include("GIT")
  expect(@repository_types).to include("SVN")
end

Then(/^I should get the given repository$/) do
  expect(@response).to eq(@repository)
end

Then(/^the response should contain the given repository$/) do
  expect(@response.first.project_id).to eq(@project.id)
end

Then(/^the repositories should contain the project id$/) do
  expect(@response.first.project_id).to eq(@project.id)
end
