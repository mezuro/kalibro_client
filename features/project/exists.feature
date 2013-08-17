Feature: Exists
  In order to be able to have projects
  As an developer
  I want to find wich projects exists

  @kalibro_restart
  Scenario: check a valid project
    Given I have a project with name "Kalibro"
    Then the project should exist
