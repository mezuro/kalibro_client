Feature: Last processing state
  In order to be able to retrieve processing results
  As a developer
  I want to be able to check the last processing status

  @kalibro_processor_restart @kalibro_configuration_restart
  Scenario: With one repository just after starting to process
    Given I have a project with name "Kalibro"
    And I have a kalibro configuration with name "Conf"
    And I have a reading group with name "Group"
    And I have a "saikuro" configuration within the given kalibro configuration
    And the given project has the following Repositories:
      |   name    | scm_type |                       address                    |
      |  Kalibro  |    GIT   | https://github.com/mezuro/kalibro_processor.git  |
    And I call the process method for the given repository
    And I wait up to 1 seconds
    When I call the last_processing_state method for the given repository
    Then I should get a valid state
