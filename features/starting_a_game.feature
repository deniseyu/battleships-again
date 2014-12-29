Feature: Starting a game of Battleships
  In order to play battleships
  As a nostalgic player
  I want to start a new game

  Scenario: Registering
    Given I am on the homepage
    When I click 'New Game'
    Then I should see the question 'What is your name?'

  Scenario: Starting a game
    Given I am registered
    When I am at my command center
    Then I should see two boards - the firing board and my board
    And I should see a link to place my ships on the board