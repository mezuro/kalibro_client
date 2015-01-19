Feature: Children
  In order to be able to have the children of a module result
  As a developer
  I want to find children module results

  @kalibro_restart @kalibro_processor_restart
  Scenario: find a valid module result
    Given I have a project with name "Kalibro"
    And I have a configuration with name "Java"
    And I have a reading group with name "Group"
    And I have a loc configuration within the given configuration
    And the given project has the following Repositories:
      |   name    | type |              address                        |
      |  Kalibro  |  GIT | https://git.gitorious.org/sbking/sbking.git |
    And I call the process method for the given repository
    And I wait up for a ready processing
    When I ask for the children of the processing root module result
    Then I should get a list with the children module results
    And The first children should have a module