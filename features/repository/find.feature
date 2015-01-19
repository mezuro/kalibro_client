Feature: Repositories listing
  In order to be able to visualize a specific repository
  As a developer
  I want to find that repository

  @kalibro_processor_restart @kalibro_configuration_restart
  Scenario: With existing project repository
    Given I have a project with name "Kalibro"
    And I have a configuration with name "Java"
    And the given project has the following Repositories:
      |   name    | scm_type |                  address                    |
      | "Kalibro" |    GIT   | https://git.gitorious.org/sbking/sbking.git |
    When I ask to find the given repository
    Then I should get the given repository
