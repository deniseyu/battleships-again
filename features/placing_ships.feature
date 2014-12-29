Feature: Placing ships on the board
  As a player who has already registered
  And is at the command center
  I want to place my ships on my board
  In order to begin gameplay

  Scenario: Placing the first ship
    Given I am on the place ships page
    When I click 'Battleship'
    And I choose the orientation and starting coordinate
    Then I should see the message, "Ship successfully placed!"
    And see a corresponding number of cells on my board reflecting a ship

