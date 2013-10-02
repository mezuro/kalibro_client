When(/^I call the metric results of method with the results root id of the given processing$/) do
  @response = KalibroEntities::Entities::MetricResult.metric_results_of(@response.results_root_id)
end

Given(/^I search a metric result with descendant results for the given metric result$/) do
  first_module_result = KalibroEntities::Entities::ModuleResult.find(@response.results_root_id)

  first_module_result.children.each do |module_result|
    metric_results = KalibroEntities::Entities::MetricResult.metric_results_of(module_result.id)

    metric_results.each do |metric_result|
      @response = metric_result.descendant_results
      puts @response.inspect
      return if !@response.first.nil?
    end
  end
end

When(/^I call the history of method with the metric name and the results root id of the given processing$/) do
  @response = KalibroEntities::Entities::MetricResult.history_of(@metric.name, @response.results_root_id)
end

Then (/^I should get a Float list$/) do
  @response.should be_a(Array)
  @response.first.should be_a(Float)
end

Then(/^I should get a list of metric results$/) do
  @response.should be_a(Array)
  @response.first.should be_a(KalibroEntities::Entities::MetricResult)
end

Then(/^I should get a list of date metric results$/) do
  @response.should be_a(Array)
  @response.first.should be_a(KalibroEntities::Entities::DateMetricResult)
end