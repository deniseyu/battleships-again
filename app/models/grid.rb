require_relative 'cell'

class Grid

  attr_reader :coordinates

  def populateGrid
    @coordinates = Hash.new
    letters = ("A".."J").to_a
    numbers = (1..10).to_a
    letters.map do |letter|
      numbers.map do |number|
        @coordinates["#{letter}#{number}"] = Cell.new
      end
    end
  end

  def fetch(coordinate)
    @coordinates[coordinate]
  end

end