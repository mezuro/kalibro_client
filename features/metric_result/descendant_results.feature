Feature: Descendant results
  In order to be able to get the descendant results of a processed repository
  As a developer
  I want to get the descendant metric results of the given module result

  @kalibro_restart @wip
  Scenario: when there is a metric result
    Given I have a project with name "Kalibro"
    And I have a configuration with name "Java"
    And I have a reading group with name "Group"
    And I have a metric configuration within the given configuration
    And the given project has the following Repositories:
      |   name    | type |              address                  |
      |  Kalibro  |  GIT | https://github.com/mezuro/kalibro.git |
    And I call the process method for the given repository
    And I wait up for a ready processing
    And I call the first_processing_of method for the given repository
    And I search a metric result with descendant results for the given metric result
    Then I should get a Float list