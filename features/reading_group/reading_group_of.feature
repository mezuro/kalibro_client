Feature: Listing MetricConfiguration's ReadingGroup
  In order to be able to edit MetricConfiguration
  As a developer
  I want to be able to fetch the RedingGroup for it's MetricConfiguration

  #MetricConfiguration implementation pending
  @wip @kalibro_restart
  Scenario: with one ReadingGroup
    Given I have a sample ReadingGroup
    And I have a sample MetricConfiguration
    When I call the reading_group_of method for the sample MetricConfiguration
    Then I should get the sample RedingGroup
