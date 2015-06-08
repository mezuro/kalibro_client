Given(/^I wait up to (\d+) seconds$/) do |seconds|
  sleep(seconds.to_i)
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
  expect(@response.process_times.first).to be_a(KalibroClient::Entities::Processor::ProcessTime)
end
