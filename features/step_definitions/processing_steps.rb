Given(/^I wait up to (\d+) seconds$/) do |seconds|
  sleep(seconds.to_i)
end

Given(/^I wait up for a ready processing$/) do
  unless KalibroClient::Entities::Processor::Processing.has_ready_processing(@repository.id)
    while(true)
      if KalibroClient::Entities::Processor::Processing.has_ready_processing(@repository.id)
        break
      else
        sleep(10)
      end
    end
  end
end

When(/^I call the has_processing for the given repository$/) do
  @response = KalibroClient::Entities::Processor::Processing.has_processing(@repository.id)
end

When(/^I call the has_ready_processing for the given repository$/) do
  @response = KalibroClient::Entities::Processor::Processing.has_ready_processing(@repository.id)
end

When(/^I call the has_processing_after for the given repository with yerterday's date$/) do
  @response = KalibroClient::Entities::Processor::Processing.has_processing_after(@repository.id, DateTime.now - 1)
end

When(/^I call the has_processing_before for the given repository with tomorrows's date$/) do
  @response = KalibroClient::Entities::Processor::Processing.has_processing_before(@repository.id, DateTime.now + 1)
end

When(/^I call the last_processing_state_of method for the given repository$/) do
  @response = KalibroClient::Entities::Processor::Processing.last_processing_state_of(@repository.id)
end

When(/^I call the last_ready_processing_of method for the given repository$/) do
  @response = KalibroClient::Entities::Processor::Processing.last_ready_processing_of(@repository.id)
end

When(/^I call the first_processing_of method for the given repository$/) do
  @response = KalibroClient::Entities::Processor::Processing.first_processing_of(@repository.id)
end

When(/^I call the last_processing_of method for the given repository$/) do
  @response = KalibroClient::Entities::Processor::Processing.last_processing_of(@repository.id)
end

When(/^I call the first_processing_after method for the given repository and yesterday's date$/) do
  @response = KalibroClient::Entities::Processor::Processing.first_processing_after(@repository.id, DateTime.now - 1)
end

When(/^I call the last_processing_before method for the given repository and tomorrow's date$/) do
  @response = KalibroClient::Entities::Processor::Processing.last_processing_before(@repository.id, DateTime.now + 1)
end

When(/^I call the processing_of method for the given repository$/) do
  @response = KalibroClient::Entities::Processor::Processing.processing_of(@repository.id)
end

When(/^I call the processing_with_date_of method for the given repository and tomorrow's date$/) do
  @response = KalibroClient::Entities::Processor::Processing.processing_with_date_of(@repository.id, DateTime.now + 1)
end

When(/^I call the processing_with_date_of method for the given repository and yesterday's date$/) do
  @response = KalibroClient::Entities::Processor::Processing.processing_with_date_of(@repository.id, DateTime.now - 1)
end

Then(/^I should get a Processing with state "(.*?)"$/) do |state|
  expect(@response.state).to eq(state)
end

Then(/^I should get nil$/) do
  expect(@response).to be_nil
end

Then(/^I should get "(.*?)"$/) do |state|
  expect(@response).to eq(state)
end

Then(/^I should get false$/) do
  expect(@response).to be_falsey
end

Then(/^I should get true$/) do
  expect(@response).to be_truthy
end

Then(/^I should get a Processing$/) do
  expect(@response).to be_a(KalibroClient::Entities::Processor::Processing)
end

Then(/^this processing should have process times$/) do
  expect(@response.process_time.first).to be_a(KalibroClient::Entities::Processor::ProcessTime)
end
