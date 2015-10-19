require 'pry-byebug'

require_relative 'game'
require_relative 'move'

puts 'clear'
puts "Playing TTT....."

def expect(thing, other_thing)
  raise "#{thing} did not equal #{other_thing}" unless thing == other_thing
end

def print_board(g)
  puts(g.board.each_slice(3).map do |row|
    row.map { |e| e || ' ' }.join(' | ')
  end.join("\n---------\n"))
end


g = Game.new

expect(g.class.name, "Game") #puts g.class.name == "Game"
expect g.moves, []     #puts g.moves == []


g.player1 = "Michael"
g.player2 = "Neil"

expect g.player1, 'Michael'
expect g.player2, 'Neil'

g.make_move 'Michael', 4


expect g.moves.last.class.name, "Move"
expect g.moves.last.player, "Michael"
expect g.moves.last.square, 4
expect g.moves.last.symbol, "X"


g.make_move 'Neil', 2
expect g.moves.last.player, "Neil"
expect g.moves.last.square, 2
expect g.moves.last.symbol, "O"

expect(g.finished?, false)

g.make_move 'Michael', 0
g.make_move 'Neil', 1
g.make_move 'Michael', 8

expect g.finished?, true

expect g.result, "Michael won!"


g = Game.new
puts "What is player1's name"
g.player1 = gets.chomp
puts "What is player2's name"

puts "It's a 2 player game. Please choose different name" if g.player1 == gets.chomp
g.player2 = gets.chomp

until g.finished?
  puts 'clear'
  puts print_board(g)
  puts "Where's #{g.whose_turn}'s move? [between 0 and 9]"
  square = gets.to_i

  case
  when square > 9 || square < 0
    puts "Move should be less than 9"
  when g.board[square] == 'X' ||  g.board[square] == 'O' 
    puts "It's already been taken, choose other move"
  else
    g.make_move(g.whose_turn, square)
  end

  # binding.pry

end

puts 'clear'
puts print_board(g)
puts g.result



binding.pry; ''