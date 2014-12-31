Feature: Joining an existing game
  When one player is registered and a game is underway
  Player Two should be able to join the same game

  Scenario: Player One is registered
    Given I am registered
    When I visit the index page in a new browser window
    Then I should see a link 'Join Game'
