Given(/^I have a project$/) do
  @project = FactoryGirl.build(:project)
end

Given(/^the project name is "(.*?)"$/) do |name|
  @project.name = name
end

Given(/^I have a project with name "(.*?)"$/) do |name|
  @project = FactoryGirl.create(:project, {name: name, id: nil})
end

When(/^I save the project$/) do
  @project.save
end

When(/^I create the project with name "(.*?)"$/) do |name|
  @project = FactoryGirl.create(:project, {name: name, id: nil})
end

When(/^I search a project with the same id of the given project$/) do
  @found_project = KalibroGem::Entities::Project.find(@project.id)
end

When(/^I destroy the project with the same id of the given project$/) do
  @found_project = KalibroGem::Entities::Project.find(@project.id)
  @found_project.destroy
end

When(/^I ask for all the projects$/) do
  @all_projects = KalibroGem::Entities::Project.all
end

Then(/^the project should exist$/) do
  KalibroGem::Entities::Project.exists?(@project.id)
end

Then(/^it should return the same project as the given one$/) do
  @found_project == @project
end

Then(/^the project should not exist$/) do
  !KalibroGem::Entities::Project.exists?(@found_project.id)
end

Then(/^I should get a list with the given project$/) do
  @all_projects.include?(@project)
end