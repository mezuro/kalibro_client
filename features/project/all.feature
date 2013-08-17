Feature: All
  In order to be able to have projects
  As an developer
  I want to get all the available projects

  @kalibro_restart
  Scenario: one project
    Given I have a project with name "Kalibro"
    When I get all the projects
    Then it should return the created project inside of an array