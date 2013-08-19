Feature: All
  In order to be able to have configurations
  As an developer
  I want to get all the available configurations

  @kalibro_restart
  Scenario: one configuration
    Given I have a configuration with name "Java"
    When I get all the configurations
    Then it should return the created configuration inside of an array