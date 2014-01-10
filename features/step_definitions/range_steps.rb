Given(/^I have a range within the given reading$/) do
  @range = FactoryGirl.build(:range, {id: nil, reading_id: @reading.id})
  @range.save @metric_configuration.id
end

Given(/^I have an unsaved range$/) do
  @range = FactoryGirl.build(:range, {id: nil})
end

Given(/^I have an unsaved range within the given reading$/) do
  @range = FactoryGirl.build(:range, {id: nil, reading_id: @reading.id})
end

When(/^I ask to save the given range$/) do
  @range.save @metric_configuration.id
end

When(/^I ask to save the given range with an inexistent metric configuration$/) do
  @range.save rand(Time.now.to_i)
end

When(/^I ask ranges of the given metric configuration$/) do
  @response = KalibroGem::Entities::Range.ranges_of @metric_configuration.id
end

When(/^I ask for all the ranges$/) do
  @response = KalibroGem::Entities::Range.all
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