Feature: Creation
  In order to be able to have configurations
  As an developer
  I want to create configurations

  @kalibro_configuration_restart
  Scenario: create a valid configuration
    When I create the configuration with name "Kalibro"
    Then the configuration should exist
