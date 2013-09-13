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

Then(/^I should get success$/) do
  @response == true
end

When(/^I ask for repositories from the given project$/) do
  @repositories_of = KalibroEntities::Entities::Repository.repositories_of(@project.id)
end

Then(/^I should get the repository given$/) do
  @repositories_of.include?(@repository)
end

When(/^I call the process method for the given repository$/) do
  @response = @repository.process
end

When(/^I list types$/) do
  @repository_types = KalibroEntities::Entities::Repository.repository_types
end

Then(/^I should get an array of types$/) do
  @repository_types.is_a?(Array)
  @repository_types.count >= 1
end