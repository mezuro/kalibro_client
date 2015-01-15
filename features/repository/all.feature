Feature: Repositories listing
  In order to be able to visualize repositories
  As a developer
  I want to see all the repositories on the service

  @kalibro_restart @kalibro_processor_restart
  Scenario: With existing project repository
    Given I have a project with name "Kalibro"
    And I have a configuration with name "Java"
    And the given project has the following Repositories:
      |   name    | scm_type |                  address                    |
      | "Kalibro" |    GIT   | https://git.gitorious.org/sbking/sbking.git |
    When I ask for all the repositories
    Then the response should contain the given repository
