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
  @response = KalibroGatekeeperClient::Entities::Range.ranges_of @metric_configuration.id
end

When(/^I try to save a range with an inexistent metric configuration$/) do
    @range = FactoryGirl.build(:range, {id: nil, reading_id: @reading.id})
    @range.metric_configuration_id = rand(Time.now.to_i)
    @range.save 
end 

When(/^I ask for all the ranges$/) do
  @response = KalibroGatekeeperClient::Entities::Range.all
end

When(/^I search a range with the same id of the given range$/) do
  @found_range = KalibroGatekeeperClient::Entities::Range.find(@range.id.to_i)
end

Then(/^I should get an empty list$/) do
  @response.should eq([])
end

Then(/^I should not get an empty list$/) do
  @response.should_not eq([])
end

Then(/^I should get a list with the given range$/) do
  @response.size.should eq(1)
  @response.first.comments.should eq(@range.comments)
end

Then(/^I should get an error in range kalibro errors attribute$/) do
  @range.kalibro_errors.should_not eq([])
end

Then(/^the id of the given range should be set$/) do
  @range.id.should_not eq(0)
end

Then(/^it should return the same range as the given one$/) do
  @found_range == @range
end

Then(/^the range should exist$/) do
  KalibroGatekeeperClient::Entities::Range.exists?(@range.id)
end