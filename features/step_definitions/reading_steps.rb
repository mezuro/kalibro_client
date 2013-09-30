Given(/^I have a reading within the given reading group$/) do
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

