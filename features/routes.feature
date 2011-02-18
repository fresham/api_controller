Feature: API Generator
  In order to allow access to data
  As a rails developer
  I want to generate a controller, routes, and a test for that controller

  Scenario: Generate standard API for resource
    Given a new rails app
    When I run "rails g scaffold person"
    And I run "rails g api people"
    Then I should see the following files
      | app/controllers/api/v1/people_api_controller.rb |
      | test/functional/api/v1/people_api_test.rb       |
    And I should see "resources :people" in file "config/routes.rb"

  Scenario: Generate API with a different version

  Scenario: Generate API with Test::Unit tests

  Scenario: Generate API with cucumber tests

  Scenario: Generate API with shoulda tests

  Scenario: Generate blank API

  Scenario: Generate API controller

  Scenario: Generate API test

  Scenario: Generate API routes
