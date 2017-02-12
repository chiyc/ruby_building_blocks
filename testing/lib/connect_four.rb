require "board.rb"
require "piece.rb"
require "interface.rb"

class ConnectFour
  include Interface
  attr_reader :board, :current_player

  def initialize
    @board = Board.new
    @current_player = 1
  end

  def check(move)
    if move.length != 1
      return false
    end
    if move.ord < 48 || move.ord > 54 # ascii codes for '0' and '6'
      return false
    elsif @board.is_full?(move.to_i)
      return false
    end
    return true
  end

  def play(move)
    if check(move)
      move = move.to_i
      board.play(@current_player,move)
      @current_player = 3 - @current_player
      return true
    else
      return false
    end
  end
end