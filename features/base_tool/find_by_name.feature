Feature: Find By Names
  In order to be able to have base tools
  As an developer
  I want to get a base tool by name

  Scenario: get a base tool by name
    When I search base tool Analizo by name
    Then I should get Analizo base tool

  Scenario: get a base tool by inexistent name
    When I search base tool Avalio by name
    Then I should get an error