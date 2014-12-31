require './app/models/player'

describe 'Player' do

  let(:player) { Player.new }

  it 'has his own board' do
    expect(player.own_board.class).to eq Grid
  end

  it 'has 0 points' do
    expect(player.points).to eq 0
  end

  it 'has a firing board' do
    expect(player.firing_board.class).to eq Grid
  end

  it 'has five ships' do
    player.get_ships!
    expect(player.ships.length).to eq 5
  end

  it 'knows that five ships are initially floating' do
    player.get_ships!
    expect(player.number_of_ships_floating).to eq 5
  end

  it 'should know that four ships are floating when one sinks' do
    player.get_ships!
    patrolboat = player.ships[1]
    2.times { patrolboat.get_hit }
    expect(patrolboat).not_to be_floating
    expect(player.number_of_ships_floating).to eq 4
  end

  it 'should know when all ships are sunk' do
    player.get_ships!
    player.ships.each { |ship| ship.hit_points = 0 }
    expect(player.all_ships_sunk?).to eq true
  end

  context 'checking out my fleet' do
    before(:each) do
      player.get_ships!
    end

    it 'has a battleship' do
      expect(player.ships).to include Battleship
    end

    it 'has a patrol boat' do
      expect(player.ships).to include Patrolboat
    end

    it 'has a dreadnought' do
      expect(player.ships).to include Dreadnought
    end

    it 'has a destroyer' do
      expect(player.ships).to include Destroyer
    end

    it 'has a submarine' do
      expect(player.ships).to include Submarine
    end
  end

  context 'placing ships on own board' do
    before(:each) do
      player.get_ships!
    end

    it 'can place a ship in a cell' do
      battleship = player.ships[0]
      player.place(battleship, "A3")
      expect(player.own_board.fetch("A3").content).to eq battleship
    end

    it 'cannot place a ship in the same cell twice' do
      battleship = player.ships[0]
      player.place(battleship, "A3")
      expect{ (player.place(battleship, "A3")) }.to raise_error('No ship can go here!')
    end

    it 'cannot try to place a ship in a starting coordinate that will cause it to go off the board' do
      battleship = player.ships[0]
      player.place(battleship, "A10")
      expect{ (player.place(battleship, "A10")) }.to raise_error('No ship can go here!')
    end

    it 'should know when all of her ships have been placed' do
      player.place_horizontal(player.ships[0], "A1")
      player.place_horizontal(player.ships[1], "C1")
      player.place_horizontal(player.ships[2], "E1")
      player.place_horizontal(player.ships[3], "F1")
      player.place_horizontal(player.ships[4], "G1")
      expect(player.all_ships_placed?).to eq true
    end

    it 'should not think all of her ships are placed when they are not' do
      player.place_horizontal(player.ships[0], "A1")
      player.place_horizontal(player.ships[1], "C1")
      player.place_horizontal(player.ships[2], "E1")
      player.place_horizontal(player.ships[3], "F1")
      expect(player.all_ships_placed?).to eq false
    end

    context 'vertically' do
      it 'can vertically place a Patrolboat over two vertically adjacent cells' do
        patrolboat = player.ships[1]
        player.place_vertical(patrolboat, "A1")
        expect(player.own_board.fetch("A1").content).to eq patrolboat
        expect(player.own_board.fetch("B1").content).to eq patrolboat
      end

      it 'should place the patrolboat only in those vertically adjacent cells' do
        patrolboat = player.ships[1]
        player.place_vertical(patrolboat, "A1")
        expect(player.own_board.fetch("A2").content).not_to eq patrolboat
        expect(player.own_board.fetch("C1").content).not_to eq patrolboat
      end

      it 'can vertically place a battleship over a number of adjacent cells equal to the size of the ship' do
        battleship = player.ships[0]
        player.place_vertical(battleship, "A1")
        expect(player.own_board.fetch("A1").content).to eq battleship
        expect(player.own_board.fetch("B1").content).to eq battleship
        expect(player.own_board.fetch("C1").content).to eq battleship
        expect(player.own_board.fetch("D1").content).to eq battleship
      end
    end

    context 'horizontally' do
      it 'can place a patrolboat in two horizontally adjacent cells' do
        patrolboat = player.ships[1]
        player.place_horizontal(patrolboat, "D3")
        expect(player.own_board.fetch("D3").content).to eq patrolboat
        expect(player.own_board.fetch("D4").content).to eq patrolboat
      end

      it 'should place the patrolboat only in those horizontally adjacent cells' do
        patrolboat = player.ships[1]
        player.place_horizontal(patrolboat, "E5")
        expect(player.own_board.fetch("E7").content).not_to eq patrolboat
        expect(player.own_board.fetch("G5").content).not_to eq patrolboat
      end

      it 'can vertically place a battleship over a number of adjacent cells equal to the size of the ship' do
        battleship = player.ships[0]
        player.place_horizontal(battleship, "H1")
        expect(player.own_board.fetch("H1").content).to eq battleship
        expect(player.own_board.fetch("H2").content).to eq battleship
        expect(player.own_board.fetch("H3").content).to eq battleship
        expect(player.own_board.fetch("H4").content).to eq battleship
      end
    end
  end

  context 'firing shots' do

    let(:opponent) { Player.new }

    it 'a coordinate should initially not be fired at' do
      expect(player.firing_board.fetch("A5")).not_to be_fired_at
    end

    it 'should know when she has fired at a coordinate' do
      player.shoot_at("A5")
      expect(player.firing_board.fetch("A5")).to be_fired_at
    end

    it 'should not be able to fire at the same coordinate twice' do
      player.shoot_at("D7")
      expect{ player.shoot_at("D7") }.to raise_error('You cannot shoot here!')
    end
  end

end