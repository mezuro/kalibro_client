Given(/^I have a range within the given reading$/) do
  @range = FactoryGirl.build(:range, {id: nil, reading_id: @reading.id, metric_configuration_id: @metric_configuration.id})
  @range.save
end

Given(/^I have an unsaved range$/) do
  @range = FactoryGirl.build(:range, {id: nil})
end

Given(/^I have an unsaved range within the given reading$/) do
  @range = FactoryGirl.build(:range, {id: nil, reading_id: @reading.id, metric_configuration_id: @metric_configuration.id})
end

When(/^I ask to save the given range$/) do
  @range.save
end

When(/^I ask to save the given range with an inexistent metric configuration$/) do
  @range.metric_configuration_id = rand(Time.now.to_i)
  @range.save
end

When(/^I ask ranges of the given metric configuration$/) do
  @response = KalibroClient::Entities::Range.ranges_of @metric_configuration.id
end

When(/^I try to save a range with an inexistent metric configuration$/) do
    @range = FactoryGirl.build(:range, {id: nil, reading_id: @reading.id})
    @range.metric_configuration_id = rand(Time.now.to_i)
    @range.save
end

When(/^I ask for all the ranges$/) do
  @response = KalibroClient::Entities::Range.all
end

When(/^I search a range with the same id of the given range$/) do
  @found_range = KalibroClient::Entities::Range.find(@range.id.to_i)
end

Then(/^I should get an empty list$/) do
  expect(@response).to eq([])
end

Then(/^I should not get an empty list$/) do
  expect(@response).to_not eq([])
end

Then(/^I should get a list with the given range$/) do
  expect(@response.size).to eq(1)
  expect(@response.first.comments).to eq(@range.comments)
end

Then(/^I should get an error in range kalibro errors attribute$/) do
  expect(@range.kalibro_errors).to_not eq([])
end

Then(/^the id of the given range should be set$/) do
  expect(@range.id).to_not eq(0)
end

Then(/^it should return the same range as the given one$/) do
  expect(@found_range).to eq(@range)
end

Then(/^the range should exist$/) do
  expect(KalibroClient::Entities::Range.exists?(@range.id)).to be_truthy
end
