Given(/^I have a module result$/) do
  Pending
  @module_result = FactoryGirl.create(:module_result)
end

When(/^I ask a module result with the same id of the given module result$/) do
  @found_module_result = KalibroEntities::Entities::ModuleResult.find(@module_result.id)
end

When(/^I ask for an inexistent module result$/) do
  @is_error = false
  begin
    KalibroEntities::Entities::ModuleResult.find(-1)
  rescue KalibroEntities::Errors::RecordNotFound
    @is_error = true
  end
end

Then(/^I should get the given module result$/) do
  @found_module_result == @module_result
end

When(/^I ask for the children of the processing root module result$/) do
  @children = KalibroEntities::Entities::ModuleResult.
    find(KalibroEntities::Entities::Processing.processing_of(@repository.id).results_root_id)
end

Then(/^I should get a list with the children module results$/) do
  @children.should be_a(KalibroEntities::Entities::ModuleResult)
end