Given(/^I have a module result$/) do
  Pending
  @module_result = FactoryGirl.create(:module_result)
end

When(/^I search a module result with the same id of the given module result$/) do
	raise @module_result.inspect
  @found_module_result = KalibroEntities::Entities::ModuleResult.find(@module_result.id)
end

When(/^I search an inexistent module result$/) do
  @is_error = false
  begin
    KalibroEntities::Entities::ModuleResult.find(-1)
  rescue KalibroEntities::Errors::RecordNotFound
    @is_error = true
  end
end

Then(/^it should return the same module result as the given one$/) do
  @found_module_result == @module_result
end

When(/^I search for the children of the processing root module result$/) do
  @children = KalibroEntities::Entities::ModuleResult.
    find(KalibroEntities::Entities::Processing.processing_of(@repository.id).results_root_id)
end

Then(/^it should return a list of the children module results$/) do
  @children.should be_a(KalibroEntities::Entities::ModuleResult)
end