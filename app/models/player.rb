require_relative 'grid'
require_relative 'ship'

class Player

  attr_accessor :own_board, :firing_board, :ships, :points, :name

  def initialize(name = nil)
    @name = name
    @own_board, @firing_board = Grid.new, Grid.new
    @own_board.populateGrid
    @firing_board.populateGrid
    @ships = []
    @points = 0
  end

  def get_ships!
    default_fleet = [Battleship.new, Patrolboat.new, Dreadnought.new, Destroyer.new, Submarine.new]
    @ships.concat(default_fleet)
  end

  def all_ships_placed?
    @ships.all? { |ship| ship.placed? }
  end

  def number_of_ships_floating
    floating_ships = @ships.select { |ship| ship.floating? }
    return floating_ships.length
  end

  def all_ships_sunk?
    self.number_of_ships_floating == 0
  end

  def place_vertical(ship, starting_coordinate)
    Array.new(ship.size).each do |cell|
      self.place(ship, starting_coordinate)
      starting_coordinate = starting_coordinate.reverse.next.reverse
    end
    ship.place!
  end

  def place_horizontal(ship, starting_coordinate)
    Array.new(ship.size).each do |cell|
      self.place(ship, starting_coordinate)
      starting_coordinate = starting_coordinate.next
    end
    ship.place!
  end

  def place(ship_unit, coordinate)
    raise 'No ship can go here!' if @own_board.fetch(coordinate).content != 'water'
    @own_board.fetch(coordinate).receive(ship_unit)
  end

  def shoot_at(coordinate, opponent = nil)
    raise 'You cannot shoot here!' if @firing_board.fetch(coordinate).fired_at?
    @firing_board.fetch(coordinate).hit!
    opponent.own_board.fetch(coordinate).hit! unless opponent == nil
  end

end