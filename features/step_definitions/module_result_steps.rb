Given(/^I have a module result$/) do
  Pending
  @module_result = FactoryGirl.create(:module_result)
end

When(/^I ask a module result with the same id of the given module result$/) do
  @found_module_result = KalibroGem::Entities::ModuleResult.find(@module_result.id)
end

When(/^I ask for an inexistent module result$/) do
  @is_error = false
  begin
    KalibroGem::Entities::ModuleResult.find(-1)
  rescue KalibroGem::Errors::RecordNotFound
    @is_error = true
  end
end

Then(/^I should get the given module result$/) do
  @found_module_result == @module_result
end

When(/^I ask for the children of the processing root module result$/) do
  @children = KalibroGem::Entities::ModuleResult.
    find(KalibroGem::Entities::Processing.processing_of(@repository.id).results_root_id)
end

Then(/^I should get a list with the children module results$/) do
  @children.should be_a(KalibroGem::Entities::ModuleResult)
end