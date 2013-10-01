When(/^I call the metric results of method with the results root id of the given processing$/) do
  @response = KalibroEntities::Entities::MetricResult.metric_results_of(@response.results_root_id)
end

Given(/^I call the descendant results method from the given metric result$/) do
  @response = @response.first.descendant_results
end

When(/^I call the history of method with the metric name and the results root id of the given processing$/) do
  @response = KalibroEntities::Entities::MetricResult.history_of(@metric.name, @response.results_root_id)
end

Then(/^I should get a list of metric results$/) do
  @response.should be_a(Array)
  @response.first.should be_a(KalibroEntities::Entities::MetricResult)
end

Then(/^I should get a list of date metric results$/) do
  @response.should be_a(Array)
  @response.first.should be_a(KalibroEntities::Entities::DateMetricResult)
end