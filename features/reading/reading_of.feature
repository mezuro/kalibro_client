Feature: Find
  In order to be able to have readings
  As an developer
  I want to get the reading of the given range

  @kalibro_restart
  Scenario: reading of a valid range
    Given I have a reading
    And I have a range that belongs to the given reading
    When I ask for the reading of the given range
    Then it should return the same reading as the given one