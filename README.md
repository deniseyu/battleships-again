# Battleships, Take Two

This is my second attempt at building a playable, fully-tested back end for Ruby Battleships.

This project is still in progress. If you want to help me, please feel free to send pull requests!

Board looks something like this:

```
| A1 | A2 | A3 | A4 | A5 | A6 | A7 | A8 | A9 | A10 |
| B1 | B2 | B3 | B4 | B5 | B6 | B7 | B8 | B9 | B10 |
| C1 | C2 | C3 | C4 | C5 | C6 | C7 | C8 | C9 | C10 |
| D1 | D2 | D3 | D4 | D5 | D6 | D7 | D8 | D9 | D10 |
| E1 | E2 | E3 | E4 | E5 | E6 | E7 | E8 | E9 | E10 |
| F1 | F2 | F3 | F4 | F5 | F6 | F7 | F8 | F9 | F10 |
| G1 | G2 | G3 | G4 | G5 | G6 | G7 | G8 | G9 | G10 |
| H1 | H2 | H3 | H4 | H5 | H6 | H7 | H8 | H9 | H10 |
| I1 | I2 | I3 | I4 | I5 | I6 | I7 | I8 | I9 | I10 |
| J1 | J2 | J3 | J4 | J5 | J6 | J7 | J8 | J9 | J10 |
```

# Current Progress

Currently, one player can place ships on the board and view those ships from the command center.

Next steps:
* Catch errors in Sinatra controller when placing ships improperly
* Get multiplayer mode working with sessions

# Preview

![Battleships](https://raw.github.com/deniseyu/battleships-again/master/public/place-ships-screenshot.png)

# To use:

Clone the repository:
```
git clone git@github.com:deniseyu/battleships-again.git
cd battleships-again
```

Install dependencies and start the server:
```
bundle install
shotgun
```

To test, run 'spec' from the command line.

# Design Overview

This game was designed with the SOLID principles of Object-Oriented Design in mind. Anything that has its own responsibilities is represented as a class. Class Responsibility Cards are as follows:

#### Ship
<table>
  <tr>
    <td><b>Responsibilities</b></td>
    <td>
      Know when it has been placed on the board
      <br>Float by default
      <br>Lose a hit point when it gets hit
      <br>Sink when hit points reach 0
      <br>Have a different size depending on the subclass created
    </td>
  </tr>
  <tr>
    <td><b>Dependencies</b></td>
    <td>None</td>
  </tr>
  <tr>
    <td><b>Subclasses</b></td>
    <td>
      Battleship
      <br>Patrol Boat
      <br>Destroyer
      <br>Aircraft Carrier
      <br>Submarine
    </td>
  </tr>
</table>

#### Cell

<table>
  <tr>
    <td><b>Responsibilities</b></td>
    <td>
      Know what it contains - either 'water' or a Ship object
      <br>Know if it has been fired at
    </td>
  </tr>
  <tr>
    <td><b>Dependencies</b></td>
    <td>None</td>
  </tr>
  <tr>
    <td><b>Subclasses</b></td>
    <td>None</td>
  </tr>
</table>

#### Grid (aka Board)

<table>
  <tr>
    <td><b>Responsibilities</b></td>
    <td>
      Populate itself with hash containing coordinates as keys, and Cells as values
      <br>Retrieve the content at a specified coordinate
    </td>
  </tr>
  <tr>
    <td><b>Dependencies</b></td>
    <td>Cell</td>
  </tr>
  <tr>
    <td><b>Subclasses</b></td>
    <td>None</td>
  </tr>
</table>

#### Player

<table>
  <tr>
    <td><b>Responsibilities</b></td>
    <td>
      Have two boards: own board and a firing board
      <br>Have five ships and place them on the board, vertically or horizontally
      <br>Know when all ships are placed on the board
      <br>Know how many ships are floating
      <br>Keep track of points, which increment when Player successfully hits a ship on the opponent's board
      <br>Choose a coordinate on the firing board to hit, without repeats
    </td>
  </tr>
  <tr>
    <td><b>Dependencies</b></td>
    <td>Grid
      <br>Ship
    </td>
  </tr>
  <tr>
    <td><b>Subclasses</b></td>
    <td>None</td>
  </tr>
</table>

#### Game

<table>
  <tr>
    <td><b>Responsibilities</b></td>
    <td>
      Have two players
      <br>Know when both players are ready to begin, i.e. all ships placed
      <br>Inform a player whether his attack was successful
      <br>End when one player has no floating ships
    </td>
  </tr>
  <tr>
    <td><b>Dependencies</b></td>
    <td>Player
    </td>
  </tr>
  <tr>
    <td><b>Subclasses</b></td>
    <td>None</td>
  </tr>
</table>
