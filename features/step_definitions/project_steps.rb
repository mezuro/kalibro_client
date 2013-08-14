Given(/^I have a project$/) do
  @project = KalibroEntities::Entities::Project.new
end

Given(/^the project name is "(.*?)"$/) do |name|
  @project.name = name
end

When(/^I save the project$/) do
  @project.save
end

When(/^I create the project with name "(.*?)"$/) do |name|
  @project = KalibroEntities::Entities::Project.create({name: name})
end

Then(/^the project should exist$/) do
  KalibroEntities::Entities::Project.exists?(@project.id)
end
