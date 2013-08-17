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

When(/^I destroy the project with the same id of the given project$/) do
  @found_project = KalibroEntities::Entities::Project.find(@project.id)
  @found_project.destroy
end

When(/^I get all the projects$/) do
  @all_projects = KalibroEntities::Entities::Project.all
end

Then(/^the project should exist$/) do
  KalibroEntities::Entities::Project.exists?(@project.id)
end

Then(/^it should return the same project as the given one$/) do
  @found_project == @project
end

Then(/^the project should not exist$/) do
  !KalibroEntities::Entities::Project.exists?(@found_project.id)
end


Then(/^it should return the created project inside of an array$/) do
  @all_projects.include?(@project)
end
