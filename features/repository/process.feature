Feature: Process
  In order to be have repositories
  As a developer
  I want to start the repository processing

  @kalibro_restart @kalibro_processor_restart
  Scenario: With one repository
    Given I have a project with name "Kalibro"
    And I have a configuration with name "Java"
    And I have a reading group with name "Group"
    And I have a loc configuration within the given configuration
    And the given project has the following Repositories:
      |   name    | scm_type |              address                        |
      |  Kalibro  |    GIT   | https://git.gitorious.org/sbking/sbking.git |
    When I call the process method for the given repository
    Then I should get success
