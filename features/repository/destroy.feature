Feature: Repositories destroying
  In order to manipulate repositories
  As a developer
  I want to destroy a repository

  @kalibro_processor_restart @kalibro_configuration_restart
  Scenario: With existing repository
    Given I have a project with name "Kalibro"
    And I have a configuration with name "Java"
    And the given project has the following Repositories:
      |   name    | scm_type |                  address                    |
      | "Kalibro" |    GIT   | https://git.gitorious.org/sbking/sbking.git |
    When I destroy the repository
    Then the repository should not exist

