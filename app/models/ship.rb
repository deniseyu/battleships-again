class Ship

  attr_reader :size, :name
  attr_accessor :hit_points

  def initialize(size = nil, name = nil)
    @size = size
    @floating = true
    @hit_points = size
    @placed = false
    @name = name
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
    super 4, 'Battleship'
  end
end

class Patrolboat < Ship
  def initialize
    super 2, 'Patrolboat'
  end
end

class Dreadnought < Ship
  def initialize
    super 5, 'Dreadnought'
  end
end

class Destroyer < Ship
  def initialize
    super 3, 'Destroyer'
  end
end

class Submarine < Ship
  def initialize
    super 3, 'Submarine'
  end
end