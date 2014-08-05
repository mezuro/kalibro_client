When(/^I ask a module result with the same id of the given module result$/) do
  @found_module_result = KalibroGatekeeperClient::Entities::ModuleResult.find(@module_result.id)
end

When(/^I ask for an inexistent module result$/) do
  @is_error = false
  begin
    KalibroGatekeeperClient::Entities::ModuleResult.find(-1)
  rescue KalibroGatekeeperClient::Errors::RecordNotFound
    @is_error = true
  end
end

When(/^I ask for the children of the processing root module result$/) do
  @children = KalibroGatekeeperClient::Entities::ModuleResult.
    find(KalibroGatekeeperClient::Entities::Processing.processing_of(@repository.id).results_root_id).children
end

Then(/^I should get a list with the children module results$/) do
  expect(@children.first).to be_a(KalibroGatekeeperClient::Entities::ModuleResult)
end

Then(/^I should get the given module result$/) do
  expect(@found_module_result).to eq(@module_result)
end

Given(/^I get the module result of the processing$/) do
  @module_result = KalibroGatekeeperClient::Entities::ModuleResult.
    find(KalibroGatekeeperClient::Entities::Processing.processing_of(@repository.id).results_root_id)
end

When(/^I ask for the history of the given module result$/) do
  @history = KalibroGatekeeperClient::Entities::ModuleResult.history_of(@module_result.id)
end

Then(/^I should get a list with date module results$/) do
  expect(@history).to be_a(Array)
end

Then(/^I should get a module_result$/) do
  expect(@module_result).to be_a(KalibroGatekeeperClient::Entities::ModuleResult)
end

Then(/^The first children should have a module$/) do
  expect(@children.first.module).to be_a(KalibroGatekeeperClient::Entities::Module)
end