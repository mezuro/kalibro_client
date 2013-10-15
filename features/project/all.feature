Feature: All
  In order to be able to have projects
  As an developer
  I want to get all the available projects

  @kalibro_restart
  Scenario: one project
    Given I have a project with name "Kalibro"
    When I ask for all the projects
    Then I should get a list with the given project