Feature: All
  In order to be able to have reading groups
  As a developer
  I want to get all the available reading groups

  @kalibro_restart
  Scenario: one reading group
    Given I have a reading group with name "Kalibro"
    When I get all the reading groups
    Then it should return the created reading group inside of an array