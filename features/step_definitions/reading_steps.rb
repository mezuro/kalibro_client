Given(/^the given reading group has the following readings:$/) do |table|
  hash = table.hashes.first
  hash[:group_id] = @reading_group.id
  hash[:id] = nil

  @reading = FactoryGirl.create(:reading, hash)
end

Given(/^I have a reading within the given reading group$/) do
  @reading = FactoryGirl.create(:reading, {id: nil, group_id: @reading_group.id})
end

When(/^I ask for all the readings$/) do
  @all_readings = KalibroGem::Entities::Reading.all
end

When(/^I ask for a reading with the same id of the given reading$/) do
  @found_reading = KalibroGem::Entities::Reading.find @reading.id
end

When(/^I ask for the readings of the given reading group$/) do
  @found_readings = KalibroGem::Entities::Reading.readings_of @reading_group.id
end

When(/^I ask to check if the given reading exists$/) do
  @response = KalibroGem::Entities::Reading.exists?(@reading.id)
end

Then(/^I should get the given reading$/) do
  @found_reading == @reading
end

Then(/^I should get a list with the given reading$/) do
  @found_readings.first == @reading
end

Then(/^the response should contain the given reading$/) do
  @all_readings.first == @reading
end