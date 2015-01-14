Feature: All
  In order to be able to have configurations
  As an developer
  I want to get all the available configurations

  @kalibro_configuration_restart
  Scenario: one configuration
    Given I have a configuration with name "Java"
    When I get all the configurations
    Then I should get a list with the given configuration