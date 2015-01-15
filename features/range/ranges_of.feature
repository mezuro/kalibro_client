Feature: Range of
  In order to be able to get all the ranges of a metric configuration
  As a developer
  I want to see all the ranges of the given metric configuration

  @kalibro_configuration_restart
  Scenario: With a inexistent range
    Given I have a configuration with name "Java"
    And I have a reading group with name "Group"
    And I have a metric configuration within the given configuration
    When I ask ranges of the given metric configuration
    Then I should get an empty list

  @kalibro_configuration_restart
  Scenario: With an existing range
    Given I have a configuration with name "Java"
    And I have a reading group with name "Group"
    And I have a metric configuration within the given configuration
    And I have a reading within the given reading group
    And I have a range within the given reading
    When I ask ranges of the given metric configuration
    Then I should get a list with the given range