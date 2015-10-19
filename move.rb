class Move

  attr_reader :square, :player, :symbol

  def initialize(player, square, symbol)
    @player = player
    @square = square
    @symbol = symbol
  end

end
