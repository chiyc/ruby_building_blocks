module Interface
  def display(board) # argument is instance of Board
    a = Array.new(7){Array.new(6, "\u25ef")}

    board.board.each_with_index do |c, i|
      c.each_with_index do |r, j|
        if r == 1
          a[i][j] = "\u25cd" # vertical fill
        elsif r == 2
          a[i][j] = "\u25c9" # fish eye
        end

      end
    end

    puts "0 1 2 3 4 5 6"
    puts "\u25bc \u25bc \u25bc \u25bc \u25bc \u25bc \u25bc"
    puts "#{a[0][5]} #{a[1][5]} #{a[2][5]} #{a[3][5]} #{a[4][5]} #{a[5][5]} #{a[6][5]}\n"
    puts "#{a[0][4]} #{a[1][4]} #{a[2][4]} #{a[3][4]} #{a[4][4]} #{a[5][4]} #{a[6][4]}\n"
    puts "#{a[0][3]} #{a[1][3]} #{a[2][3]} #{a[3][3]} #{a[4][3]} #{a[5][3]} #{a[6][3]}\n"
    puts "#{a[0][2]} #{a[1][2]} #{a[2][2]} #{a[3][2]} #{a[4][2]} #{a[5][2]} #{a[6][2]}\n"
    puts "#{a[0][1]} #{a[1][1]} #{a[2][1]} #{a[3][1]} #{a[4][1]} #{a[5][1]} #{a[6][1]}\n"
    puts "#{a[0][0]} #{a[1][0]} #{a[2][0]} #{a[3][0]} #{a[4][0]} #{a[5][0]} #{a[6][0]}\n"
  end

  def prompt_turn(player)
    print "Player #{player}, please select a valid move: "
    return gets.chomp
  end


end

if __FILE__ == $0
include Interface
require "./board.rb"

board = Board.new
board.board[3][0] = 1
board.board[0][0] = 1
board.board[1][0] = 2
board.board[0][1] = 2

display(board)

include Interface
puts prompt_turn(1)
end