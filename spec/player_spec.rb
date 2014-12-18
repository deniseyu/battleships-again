require 'player'

describe 'Player' do

  let(:player) { Player.new }

  it 'has his own board' do
    expect(player.own_board.class).to eq Grid
  end

  it 'has a firing board' do
    expect(player.firing_board.class).to eq Grid
  end

  it 'has five ships' do
    player.get_ships!
    expect(player.ships.length).to eq 5
  end

  context 'checking out my fleet' do
    before(:each) do
      player.get_ships!
    end

    it 'has a battleship' do
      expect(player.ships).to include Battleship
    end

    it 'has a battleship' do
      expect(player.ships).to include Patrolboat
    end

    it 'has a battleship' do
      expect(player.ships).to include AircraftCarrier
    end

    it 'has a battleship' do
      expect(player.ships).to include Destroyer
    end

    it 'has a battleship' do
      expect(player.ships).to include Submarine
    end
  end

  context 'placing ships on own board' do
    before(:each) do
      player.get_ships!
      player.own_board.populateGrid
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

    context 'when placing a ship vertically' do
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

    context 'when placing a ship horizontally' do
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
    end
  end

  context 'firing shots' do

    before(:each) do
      player.firing_board.populateGrid
    end

    it 'a coordinate should initially not be fired at' do
      expect(player.firing_board.fetch("A5")).not_to be_fired_at
    end

    it 'should know when she has fired at a coordinate' do
      player.shoot_at("A5")
      expect(player.firing_board.fetch("A5")).to be_fired_at
    end

  end

end