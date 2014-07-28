Feature: /history of
  In order to be able to have the history of a module result
  As an developer
  I want to get the history of module results

  @kalibro_restart
  Scenario: get the history of a module result
    Given I have a project with name "Kalibro"
    And I have a configuration with name "Java"
    And I have a reading group with name "Group"
    And I have a metric configuration within the given configuration
    And the given project has the following Repositories:
      |   name    | type |              address                        |
      |  Kalibro  |  GIT | https://git.gitorious.org/sbking/sbking.git |
    And I call the process method for the given repository
    And I wait up for a ready processing
    And I get the module result of the processing
    When I ask for the history of the given module result
    Then I should get a list with date module results