Feature: Find By Name
  In order to be able to have metric collectors
  As a developer
  I want to get a metric collector by name

  Scenario: get a metric collector by name!
    When I search metric collector "MetricFu" by name (strictly)
    Then I should get "MetricFu" metric collector

  Scenario: get a metric collector with a non-existent name!
    When I search metric collector "Avalio" by name (strictly)
    Then I should get an error

  Scenario: get a metric collector by name
    When I search metric collector "MetricFu" by name
    Then I should get "MetricFu" metric collector

  Scenario: get a metric collector by non-existent name
    When I search metric collector "Avalio" by name
    Then I should get nil
