Feature: Children
  In order to be able to have the children of a module result
  As an developer
  I want to find children module results

  @wip
  @kalibro_restart
  Scenario: find a valid module result
    Given I have a module result
    When I search for the children of a module result
    Then it should return a list of the children module results