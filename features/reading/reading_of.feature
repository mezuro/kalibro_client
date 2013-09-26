Feature: Find
  In order to be able to have readings
  As an developer
  I want to get the reading of the given range

  @kalibro_restart
  Scenario: reading of a valid range
    Given I have a configuration with name "Java"
    And I have a reading group with name "Kalibro"
    And I have a metric configuration within the given configuration
    And I have a reading within the given reading group
    And I have a range within the given reading
    When I ask for the reading of the given range
    Then it should return the same reading as the given one