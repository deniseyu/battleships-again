class Ship

  attr_reader :size
  attr_accessor :hit_points

  def initialize(size = nil)
    @size = size
    @floating = true
    @hit_points = size
    @placed = false
  end

  def floating?
    @floating = true unless @hit_points == 0
  end

  def place!
    @placed = true
  end

  def placed?
    @placed
  end

  def get_hit
    @hit_points -= 1
  end

end

class Battleship < Ship
  def initialize
    super 4
  end
end

class Patrolboat < Ship
  def initialize
    super 2
  end
end

class AircraftCarrier < Ship
  def initialize
    super 5
  end
end

class Destroyer < Ship
  def initialize
    super 3
  end
end

class Submarine < Ship
  def initialize
    super 3
  end
end