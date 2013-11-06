Given(/^I have a reading within the given reading group$/) do
  @reading = FactoryGirl.create(:reading, {id: nil, group_id: @reading_group.id})
end

When(/^I ask for a reading with the same id of the given reading$/) do
  @found_reading = KalibroGem::Entities::Reading.find @reading.id
end

When(/^I ask for the readings of the given reading group$/) do
  @found_readings = KalibroGem::Entities::Reading.readings_of @reading_group.id
end

Then(/^I should get the given reading$/) do
  @found_reading == @reading
end

Then(/^I should get a list with the given reading$/) do
  @found_readings.first == @reading
end

