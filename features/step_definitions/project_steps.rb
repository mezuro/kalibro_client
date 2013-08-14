Given(/^I have a project$/) do
  @project = KalibroEntities::Entities::Project.new
end

Given(/^the project name is "(.*?)"$/) do |name|
  @project.name = name
end

Given(/^I have a project with name "(.*?)"$/) do |name|
  @project = KalibroEntities::Entities::Project.create({name: name})
end

When(/^I save the project$/) do
  @project.save
end

When(/^I create the project with name "(.*?)"$/) do |name|
  @project = KalibroEntities::Entities::Project.create({name: name})
end

When(/^I search a project with the same id of the given project$/) do
  @found_project = KalibroEntities::Entities::Project.find(@project.id)
end

Then(/^the project should exist$/) do
  KalibroEntities::Entities::Project.exists?(@project.id)
end

Then(/^it should return the same project as the given one$/) do
  @found_project == @project
end

