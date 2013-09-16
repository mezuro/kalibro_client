Given(/^I have a module result$/) do
  Pending
  @module_result = FactoryGirl.create(:module_result)
end

When(/^I search a module result with the same id of the given module result$/) do
	raise @module_result.inspect
  @found_module_result = KalibroEntities::Entities::ModuleResult.find(@module_result.id)
end

Then(/^it should return the same module result as the given one$/) do
  @found_module_result == @module_result
end

When(/^I search an inexistent module result$/) do
  @is_error = false
  begin 
  	KalibroEntities::Entities::ModuleResult.find(-1)
  rescue KalibroEntities::Errors::RecordNotFound
  	@is_error = true 
  end
end