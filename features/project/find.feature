Feature: Find
  In order to be able to have projects
  As an developer
  I want to find projects

  @kalibro_restart @wip
  Scenario: find a valid project
    Given I have a configuration with name "Kalibro for Java"
    And I have a metric configuration within the given configuration
    When I search a metric configuration with the same id of the given metric configuration
    Then it should return the same metric configuration as the given one
