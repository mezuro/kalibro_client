Feature: Repositories listing
  In order to be able to visualize a specific repository
  As a developer
  I want to find that repository

  @kalibro_restart
  Scenario: With existing project repository
    Given I have a project with name "Kalibro"
    And I have a configuration with name "Java"
    And the given project has the following Repositories:
      |   name    | type |              address                  |
      | "Kalibro" |  GIT | https://github.com/mezuro/kalibro.git |
    When I ask to find the given repository
    Then I should get the given repository
