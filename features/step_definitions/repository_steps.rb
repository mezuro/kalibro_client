Given(/^I wait up for a ready processing$/) do
  unless @repository.has_ready_processing
    while(true)
      if @repository.has_ready_processing
        break
      else
        sleep(10)
      end
    end
  end
end

When(/^I call the has_processing for the given repository$/) do
  @response = @repository.has_processing
end

When(/^I call the has_ready_processing for the given repository$/) do
  @response = @repository.has_ready_processing
end

When(/^I call the has_processing_after for the given repository with yerterday's date$/) do
  @response = @repository.has_processing_after(DateTime.now - 1)
end

When(/^I call the has_processing_before for the given repository with tomorrows's date$/) do
  @response = @repository.has_processing_before(DateTime.now + 1)
end

When(/^I call the last_processing_state_of method for the given repository$/) do
  @response = @repository.last_processing_state
end

When(/^I call the last_ready_processing_of method for the given repository$/) do
  @response = @repository.last_ready_processing
end

When(/^I call the first_processing_of method for the given repository$/) do
  @response = @repository.first_processing
end

When(/^I call the last_processing_of method for the given repository$/) do
  @response = @repository.last_processing
end

When(/^I call the first_processing_after method for the given repository and yesterday's date$/) do
  @response = @repository.first_processing_after(DateTime.now - 1)
end

When(/^I call the last_processing_before method for the given repository and tomorrow's date$/) do
  @response = @repository.last_processing_before(DateTime.now + 1)
end

When(/^I call the processing_of method for the given repository$/) do
  @response = @repository.processing
end

When(/^I call the processing_with_date_of method for the given repository and tomorrow's date$/) do
  @response = @repository.processing_with_date(DateTime.now + 1)
end

When(/^I call the processing_with_date_of method for the given repository and yesterday's date$/) do
  @response = @repository.processing_with_date(DateTime.now - 1)
end

Given(/^the given project has the following Repositories:$/) do |table|
  hash = table.hashes.first
  hash[:project_id] = @project.id
  hash[:kalibro_configuration_id] = @kalibro_configuration.id

  @repository = FactoryGirl.create(:repository, hash)
end

When(/^I call the cancel_process method for the given repository$/) do
  @response = @repository.cancel_processing_of_repository
end

When(/^I ask for repositories from the given project$/) do
  @response = KalibroClient::Entities::Processor::Repository.repositories_of(@project.id)
end

When(/^I call the process method for the given repository$/) do
  @response = @repository.process
end

When(/^I list types$/) do
  @repository_types = KalibroClient::Entities::Processor::Repository.repository_types
end

When(/^I ask for all the repositories$/) do
  @response = KalibroClient::Entities::Processor::Repository.all
end

When(/^I ask to find the given repository$/) do
  @response = KalibroClient::Entities::Processor::Repository.find(@repository.id)
end

When(/^I ask to check if the given repository exists$/) do
  @response = KalibroClient::Entities::Processor::Repository.exists?(@repository.id)
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

When(/^I destroy the repository$/) do
  @repository.destroy
end

Then(/^the repository should no longer exist$/) do
  expect(KalibroClient::Entities::Processor::Repository.exists?(@repository.id)).to be_falsey
end

