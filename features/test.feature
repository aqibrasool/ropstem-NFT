Feature: Verify all possible entries

  As a QA Engineer
  I want to verify the reported issue
  So that I can confirm the fix

  Background:
    Given the application is running

  Scenario: TC001 - Reproduce reported issue
    Given the user is on the home page
    When the user enters all possible values
    Then the application should handle all possible entries without errors or warnings