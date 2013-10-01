Given(/^I have a metric with name "(.*?)"$/) do |name|
  @metric = FactoryGirl.create(:metric, {name: name})
end
