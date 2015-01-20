Feature: Metric Configurations
  In order to see the metric configurations
  As a developer
  I want to list all the metric configurations of a configuration

  @kalibro_configuration_restart
  Scenario: one metric configuration
    Given I have a configuration with name "Java"
    And the configuration has a metric configuration
    When I list all the metric configurations of the configuration
    Then I should get a list with the given metric configuration

