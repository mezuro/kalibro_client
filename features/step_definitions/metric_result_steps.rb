When(/^I call the metric results of method with the results root id of the given processing$/) do
  @response = KalibroGem::Entities::MetricResult.metric_results_of(@response.results_root_id)
end

Given(/^I search a metric result with descendant results for the given metric result$/) do
  first_module_result = KalibroGem::Entities::ModuleResult.find(@response.results_root_id)

  metric_results = KalibroGem::Entities::MetricResult.metric_results_of(first_module_result.id)
  @response = metric_results.first.descendant_results
end

When(/^I call the history of method with the metric name and the results root id of the given processing$/) do
  @response = KalibroGem::Entities::MetricResult.history_of(@metric.name, @response.results_root_id)
end

Then (/^I should get a Float list$/) do
  @response.should be_a(Array)
  @response.first.should be_a(Float)
end

Then(/^I should get a list of metric results$/) do
  @response.should be_a(Array)
  @response.first.should be_a(KalibroGem::Entities::MetricResult)
end

Then(/^I should get a list of date metric results$/) do
  @response.should be_a(Array)
  @response.first.should be_a(KalibroGem::Entities::DateMetricResult)
end