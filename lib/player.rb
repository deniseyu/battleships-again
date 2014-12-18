require_relative 'grid'
require_relative 'ship'

class Player

  attr_accessor :own_board, :firing_board, :ships

  def initialize
    @own_board = Grid.new
    @firing_board = Grid.new
    @ships = []
  end

  def get_ships!
    default_fleet = [Battleship.new, Patrolboat.new, AircraftCarrier.new, Destroyer.new, Submarine.new]
    @ships.concat(default_fleet)
  end

  def place_vertical(ship, starting_coordinate)
    cells_to_occupy = Array.new(ship.size)
    cells_to_occupy.each do |cell|
      self.place(ship, starting_coordinate)
      starting_coordinate = starting_coordinate.reverse.next.reverse
    end
  end

  def place_horizontal(ship, starting_coordinate)
    cells_to_occupy = Array.new(ship.size)
    cells_to_occupy.each do |cell|
      self.place(ship, starting_coordinate)
      starting_coordinate = starting_coordinate.next
    end
  end

  def place(ship_unit, coordinate)
    raise 'No ship can go here!' if @own_board.fetch(coordinate).content != 'water'
    @own_board.fetch(coordinate).receive(ship_unit)
  end

  def shoot_at(coordinate)
    @firing_board.fetch(coordinate).hit!
    # if @firing_board.fetch(coordinate).content != 'water'
    #   'Success!'
    # else
    #   'You missed!'
    # end
  end



end