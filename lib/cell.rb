class Cell

  attr_accessor :content

  def initialize
    @fired_at = false
    @content = 'water'
  end

  def fired_at?
    @fired_at
  end

  def hit!
    @fired_at = true
  end

  def receive(ship)
    @content = ship
  end

end