Feature: All Names
  In order to be able to have base tools
  As an developer
  I want to get all the available base tool names

  Scenario: all base tools names
    When I get all base tool names
    Then it should return Analizo string inside of an array