require './app/models/game'

describe Game do

  let(:game) { Game.new }


  context 'setup' do

    before(:each) do
      game.add_players
    end

    def place_all_ships_on_board_of(player)
      player.get_ships!
      player.place_horizontal(player.ships[0], "A1")
      player.place_horizontal(player.ships[1], "C1")
      player.place_horizontal(player.ships[2], "E1")
      player.place_horizontal(player.ships[3], "F1")
      player.place_horizontal(player.ships[4], "G1")
    end

    it 'should add two players' do
      expect(game.players.count).to eq 2
    end

    it 'each player should have his own board and a firing board' do
      expect(game.players[0].own_board.class).to eq Grid
      expect(game.players[0].firing_board.class).to eq Grid
    end

    it 'should know when a player has placed all of their ships' do
      place_all_ships_on_board_of(game.player_one)
      expect(game.player_one.all_ships_placed?).to eq true
    end

    it 'should know that it is ready to start when both players have placed all ships' do
      place_all_ships_on_board_of(game.player_one)
      place_all_ships_on_board_of(game.player_two)
      expect(game).to be_ready
    end
  end

  context 'on a given turn of the game' do

    before(:each) do
      game.add_players
      game.player_one.get_ships!
      game.player_two.get_ships!
    end

    def sink_player_ones(ship)
      ship_location = game.player_one.ships.find_index(ship)
      ship.size.times { game.player_one.ships[ship_location].get_hit }
    end

    def sink_all_of_player_ones_ships
      game.player_one.ships.each { |ship| ship.hit_points = 0 }
    end

    it 'should know how many ships Player One has floating' do
      expect(game.player_one.number_of_ships_floating).to eq 5
      sink_player_ones(game.player_one.ships[0])
      expect(game.player_one.number_of_ships_floating).to eq 4
    end

    it 'should announce the game is over if Player One has no floating ships' do
      sink_all_of_player_ones_ships
      expect(game).to be_over
    end

    context 'when Player One shoots at Player Two' do

      before(:each) do
        battleship = game.player_two.ships[0]
        game.player_two.place_horizontal(battleship, "A1")
        game.player_one.shoot_at("A1", game.player_two)
      end

      it 'should reflect that a cell has been fired at, on the firing board and the opponents actual board' do
        expect(game.player_two.own_board.fetch("A1")).to be_fired_at
        expect(game.player_one.firing_board.fetch("A1")).to be_fired_at
      end

      it 'should inform Player One if he has hit a ship on Player Twos board' do
        expect(game.result(game.player_one, game.player_two, "A1")).to eq 'success!'
      end

      it 'should inform Player One if he has missed' do
        game.player_one.shoot_at("G3", game.player_two)
        expect(game.result(game.player_one, game.player_two, "G3")).to eq 'you missed!'
      end

      it 'should award Player One a point for successfully hitting a ship' do
        game.result(game.player_one, game.player_two, "A1")
        expect(game.player_one.points).to eq 1
      end

      it 'should not award Player One a point if he has missed' do
        game.player_one.shoot_at("G3", game.player_two)
        expect(game.player_one.points).to eq 0
      end

    end

  end

end