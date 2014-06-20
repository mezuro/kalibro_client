Given(/^I have a module result$/) do
  Pending
  @module_result = FactoryGirl.create(:module_result)
end

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
    find(KalibroGatekeeperClient::Entities::Processing.processing_of(@repository.id).results_root_id)
end

Then(/^I should get a list with the children module results$/) do
  expect(@children).to be_a(KalibroGatekeeperClient::Entities::ModuleResult)
end

Then(/^I should get the given module result$/) do
  expect(@found_module_result).to eq(@module_result)
end