Feature: Reading destruction
  In order to be able to manipulate readings
  As a developer
  I want to destroy a reading

  @kalibro_configuration_restart
  Scenario: With existing reading group reading
    Given I have a reading group with name "RG"
    And the given reading group has the following readings:
      |   label   | grade |     color    |
      | "Awesome" |  10   |     3333ff   |
    When I destroy the reading
    Then the reading should not exist

