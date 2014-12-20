require './app/models/ship'

describe Ship do

  context 'a ship of any size' do

    let(:ship) { Ship.new }

    it 'should be an instance of the Ship class' do
      expect(ship.class).to eq Ship
    end

    it 'should initially be floating' do
      expect(ship).to be_floating
    end

    it 'should know that it is initially not on the board' do
      expect(ship).not_to be_placed
    end

    it 'should know after it has been placed' do
      ship.place!
      expect(ship).to be_placed
    end

  end

  context 'a ship initialized with size 3' do

    let(:ship) { Ship.new(3) }

    it 'can be initialized with a size' do
      expect(ship.size).to eq 3
    end

    it 'has as many hit points as its size' do
      expect(ship.hit_points).to eq 3
    end

    it 'should lose one hit point every time it is hit' do
      ship.get_hit
      expect(ship.hit_points).to eq 2
    end

    it 'should stop floating when hit points reach 0' do
      3.times { ship.get_hit }
      expect(ship).not_to be_floating
    end

  end

  context 'ships come in many different sizes!' do

    it 'can be a battleship' do
      battleship = Battleship.new
      expect(battleship.size).to eq 4
    end

    it 'can be a patrol boat' do
      patrolboat = Patrolboat.new
      expect(patrolboat.size).to eq 2
    end

    it 'can be an aircraft carrier' do
      aircraftcarrier = AircraftCarrier.new
      expect(aircraftcarrier.size).to eq 5
    end

    it 'can be a destroyer' do
      destroyer = Destroyer.new
      expect(destroyer.size).to eq 3
    end

    it 'can be a submarine' do
      submarine = Submarine.new
      expect(submarine.size).to eq 3
    end
  end

end