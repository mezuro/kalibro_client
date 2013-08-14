Feature: Edit
  In order to be able to have projects
  As an developer
  I want to edit projects

  @kalibro_restart
  Scenario: edit a valid project
    Given I have a project with name "Kalibro"
    When I search a project with the same id of the given project
    Then it should return the same project as the given one
