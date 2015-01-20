Feature: Destroy
  In order to manipulate configurations
  As a developer
  I want to destroy a given configuration

  @kalibro_configuration_restart
  Scenario: destroying a configuration
    Given I have a configuration with name "Java"
    When I destroy the configuration
    Then the configuration should no longer exist
