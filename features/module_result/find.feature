Feature: Find
  In order to be able to have module result
  As an developer
  I want to find module results

  @wip
  @kalibro_restart
  Scenario: find a valid module result
    Given I have a module result
    When I ask a module result with the same id of the given module result
    Then I should get the given module result

  Scenario: get a module result by inexistent name
    When I ask for an inexistent module result
    Then I should get an error