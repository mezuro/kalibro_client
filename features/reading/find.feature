Feature: Find
  In order to be able to have readings
  As an developer
  I want to find reading

  @kalibro_restart
  Scenario: find a valid reading
    Given I have a reading group with name "Kalibro"
    And I have a reading within the given reading group
    When I search a reading with the same id of the given reading
    Then it should return the same reading as the given one