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

  Scenario: Placing a ship without specifying orientation
    Given I am on the place ships page
    When I click 'Battleship'
    And I enter a starting coordinate
    But I forget to choose an orientation
    Then I should see the message 'All fields need to be filled out!'

  Scenario: Placing a ship without specifying coordinate
    Given I am on the place ships page
    When I click 'Battleship'
    And I enter an orientation
    But I forget to choose a coordinate
    Then I should see the message 'All fields need to be filled out!'

  Scenario: All ships are placed
    Given I am on the place ships page
    When I place my Battleship
    And I place my Patrolboat
    And I place my Destroyer
    And I place my Submarine
    And lastly I place my Dreadnought
    Then I should see a link to begin the game