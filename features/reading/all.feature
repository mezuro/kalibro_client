Feature: Reading listing
  In order to be able to visualize readings
  As a developer
  I want to see all the readings on the service

  @kalibro_configuration_restart
  Scenario: With existing reading group reading
    Given I have a reading group with name "Kalibro"
    And the given reading group has the following readings:
      |   label   | grade |     color    |
      | "Awesome" |  10   |     3333ff   |
    When I ask for all the readings
    Then the response should contain the given reading