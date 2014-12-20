require './app/models/grid'

describe Grid do

  let(:grid) { Grid.new }

  before(:each) do
    grid.populateGrid
  end

  it 'should be composed of a giant hash' do
    expect(grid.coordinates.class).to eq Hash
  end

  it 'should have 100 cells' do
    expect(grid.coordinates.length).to eq 100
  end

  it 'should have a Cell object at A3' do
    expect(grid.coordinates["A3"].class).to eq Cell
  end

  it 'can look up a specific cell by coordinates' do
    expect(grid.fetch("A3").class).to eq Cell
  end

end