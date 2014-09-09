Feature: Reading listing
  In order to be able to check know if a reading still exists
  As a developer
  I want to check that on the service

  @kalibro_restart
  Scenario: With existing reading group reading
    Given I have a reading group with name "RG"
    And the given reading group has the following readings:
      |   label   | grade |     color    |
      | "Awesome" |  10   |     3333ff   |
    When I ask to check if the given reading exists
    Then I should get true
