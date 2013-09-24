Given(/^I have a reading$/) do
  @reading_group = FactoryGirl.create(:reading_group)
  @reading = FactoryGirl.create(:reading, {id: nil, group_id: @reading_group.id})
end

Given(/^I have a reading that belongs to the given reading group$/) do
  @reading = FactoryGirl.create(:reading, {id: nil, group_id: @reading_group.id})
end

When(/^I search a reading with the same id of the given reading$/) do
  @found_reading = KalibroEntities::Entities::Reading.find @reading.id
end

When(/^I ask for the readings of the given reading group$/) do
  @found_readings = KalibroEntities::Entities::Reading.readings_of @reading_group.id
end

Then(/^it should return the same reading as the given one$/) do
  @found_reading == @reading
end

Then(/^it should return the a list with its readings$/) do
  @found_readings.first == @reading
end

Given(/^I have a range that belongs to the given reading$/) do
  pending # pending # There is no Range entity yet!
end

When(/^I ask for the reading of the given range$/) do
  pending # There is no Range entity yet!
end
