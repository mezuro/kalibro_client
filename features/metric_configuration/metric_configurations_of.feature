Feature: MetricConfigurationsOf
  In order to be able to have configurations
  As an developer
  I want to get all metric_configurations of a configuration

  @kalibro_restart
  Scenario: get a list of all metric configurations of some configuration
	Given I have a configuration with name "Kalibro for Java"
    And I have a metric configuration within the given configuration
    When I request all metric configurations of the given configuration
    Then I should get a list of its metric configurations

  @kalibro_restart
  Scenario: get an empty list for a configuration without metric configurations
  	Given I have a configuration with name "Kalibro for Java"
    When I request all metric configurations of the given configuration
    Then I should get an empty list of metric configurations
