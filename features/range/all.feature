Feature: Range listing
  In order to be able to get all the ranges
  As a developer
  I want to see all the ranges

  @kalibro_restart
  Scenario: When there are ranges
    Given I have a configuration with name "Java"
    And I have a reading group with name "Group"
    And I have a metric configuration within the given configuration
    And I have a reading within the given reading group
    And I have a range within the given reading
    When I ask for all the ranges
    Then I should not get an empty list