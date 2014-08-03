Feature: Metric results of
  In order to be able to get the metric results of a processed repository
  As a developer
  I want to get the metric results of the given module result

  @kalibro_restart
  Scenario: when there is a metric result
    Given I have a project with name "Kalibro"
    And I have a configuration with name "Java"
    And I have a reading group with name "Group"
    And I have a loc configuration within the given configuration
    And the given project has the following Repositories:
      |   name    | type |              address                        |
      |  SBKing   |  GIT | https://git.gitorious.org/sbking/sbking.git |
    And I call the process method for the given repository
    And I wait up for a ready processing
    And I call the first_processing_of method for the given repository
    When I call the metric results of method with the results root id of the given processing
    Then I should get a list of metric results
    And the first metric result should have a metric configuration snapshot