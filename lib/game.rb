require_relative 'player'

class Game

  attr_reader :players, :player_one, :player_two

  def initialize
    @players = []
  end

  def add_players
    @player_one, @player_two = Player.new, Player.new
    @players.concat([@player_one, @player_two])
  end

  def ready?
    @players.all? { |player| player.all_ships_placed? }
  end

  def result(player, opponent, coordinate)
    if opponent.own_board.fetch(coordinate).content != 'water'
      player.points += 1
      return 'success!'
    else
      return 'you missed!'
    end
  end

  def over?
    @players.any? { |player| player.all_ships_sunk? }
  end

end