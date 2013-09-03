Given(/^I have a reading group with name "(.*?)"$/) do |name|
  @reading_group = FactoryGirl.create(:reading_group, {id: nil, name: name})
end

When(/^I get all the reading groups$/) do
  @all_reading_groups = KalibroEntities::Entities::ReadingGroup.all
end

Then(/^it should return the created reading group inside of an array$/) do
   @all_reading_groups.include?(@reading_group)
end