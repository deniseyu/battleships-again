require './app/models/cell'

describe 'Cell' do

  let(:cell) { Cell.new }
  let(:ship) { double :ship }

  it 'should not initially be fired at' do
    expect(cell).not_to be_fired_at
  end

  it 'should know when it has been fired at' do
    cell.hit!
    expect(cell).to be_fired_at
  end

  it 'should not initially contain a ship object' do
    expect(cell.content.class).not_to eq Ship
  end

  it 'should initially contain water' do
    expect(cell.content).to eq 'water'
  end

  it 'can receive a ship' do
    cell.receive(ship)
    expect(cell.content).to eq ship
  end

  it 'should not contain water when it receives a ship' do
    cell.receive(ship)
    expect(cell.content).not_to eq 'water'
  end

end