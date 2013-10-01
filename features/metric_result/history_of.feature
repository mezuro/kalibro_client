Feature: history of
  In order to be able to get the date metric results of a processed repository
  As a developer
  I want to get the date metric results of the given module result and the given metric name

  @kalibro_restart
  Scenario: when there is a metric result
    Given I have a project with name "Kalibro"
    And I have a configuration with name "Java"
    And I have a reading group with name "Group"
    And I have a metric with name "Lines of Code"
    And I have a metric configuration within the given configuration with the given metric
    And the given project has the following Repositories:
      |   name    | type |              address                        |
      |  SBKing   |  GIT | https://git.gitorious.org/sbking/sbking.git |
    And I call the process method for the given repository
    And I wait up for a ready processing
    And I call the first_processing_of method for the given repository
    When I call the history of method with the metric name and the results root id of the given processing
    Then I should get a list of date metric results