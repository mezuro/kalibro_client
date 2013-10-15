Feature: /history of
  In order to be able to have the history of a module result
  As an developer
  I want to get the history of module results

  @wip
  @kalibro_restart
  Scenario: get the history of a module result
    Given I have a module result
    When I ask for the history of the given module result
    Then I should get a list with date module results