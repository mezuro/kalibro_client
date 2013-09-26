Feature: Find
  In order to be able to have readings
  As an developer
  I want to get the readings of the given reading group

  @kalibro_restart
  Scenario: readings of a valid reading group
    Given I have a reading group with name "Kalibro"
    And I have a reading within the given reading group
    When I ask for the readings of the given reading group
    Then it should return the a list with its readings