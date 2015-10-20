class Game

  attr_accessor :player1, :player2
  attr_reader :moves

  WINNING_LINES = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8],[0,4,8],[2,4,6]]
  
  def initialize
    @moves = []
  end

  def make_move(player, square)
    if players_turn?(player) && square_in_bound?(square) && square_is_empty?(square)
      @moves << Move.new(player, square, symbol_for_player(player))
    end
  end

  def finished?
    winning_game? || drawn_game?
  end

  def result
    case
    when winning_game?
      "#{moves.last.player} won!"
    when drawn_game?
      "It is a drawn"
    else
      "Game's still in progress"
    end
  end

  def whose_turn
    return player1 if moves.empty?
    moves.last.player == player1 ? player2 : player1
  end


  
  def board
    empty_board.tap do |board|
      moves.each do |move|   # use map method?
        board[move.square] = move.symbol
      end
    end
    
    # board = empty_board
    # moves.each do |move|   # use map method?
    #   board[move.square] = move.symbol
    # end
    # board
  end
  
  def empty_board
    Array.new(9,nil)
  end


  private
  def winning_game?
    !!WINNING_LINES.detect do |winning_line|
        %w(XXX OOO).include?(winning_line.map { |e| board[e] }.join)
      end
  end

  private
  def drawn_game?
    # (0..8).all? {|i| moves[i]}
    moves.size == 9
  end

  private
  def players_turn?(player)
    whose_turn == player
  end

  private
  def square_in_bound?(square)
    return unless square.to_i.to_s == square.to_s
    square = square.to_i
    # return unless square.is_a?(FixNum)
    square < 9 && square > -1
  end

  private
  def square_is_empty?(square)
    !board[square]
  end



  private
  def symbol_for_player(player)
    case player
    when player1
      'X'
    when player2
      'O'
    else
      raise "OI! that's not one of my player"
    end
  end

end
