Feature: Verify User Login Functionality

  As a QA Engineer
  I want to verify the reported issue
  So that I can confirm the fix

  Background:
    Given the application is running

  Scenario: TC001 - Successful Login with Valid Credentials
    Given the user is on the login page
    When the user enters valid username and password
    Then the user is logged in successfully

  Scenario: TC002 - Failed Login with Invalid Credentials
    Given the user is on the login page
    When the user enters invalid username or password
    Then an error message is displayed