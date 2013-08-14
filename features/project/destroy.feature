Feature: Destroy
  In order to be able to have projects
  As an developer
  I want to detroy projects

  @kalibro_restart
  Scenario: destroy a existing project
    Given I have a project with name "Kalibro"
    When I destroy the project with the same id of the given project
    Then the project should not exist
