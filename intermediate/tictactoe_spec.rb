require 'tictactoe.rb'

describe "tic tac toe game" do
  let(:board) { Board.new }

  describe "#initialize" do
    it "sets board and game state" do
      expect(board.game_state).to eq(0)
      expect(board.board).to eq([0,0,0,0,0,0,0,0,0])
      expect(board.player).to eq(1)
    end
  end

  it "ends game when player 1 plays across top row" do
    board.board = [1,1,1,0,0,0,0,0,0]
    board.check_game
    expect(board.game_state).to eq(1)
  end

  it "does not allow bad input" do
    expect(board.play_move(1, "13")).to be false
    expect(board.play_move(1, "-1")).to be false
    expect(board.play_move(1, "ef")).to be false
  end

  it "forbids move overlap" do
    board.play_move(1, 0)
    expect(board.play_move(2, 0)).to be false
  end

  it "detects tied game" do
    board.board = [1,1,2,2,2,1,1,2,1]
    board.check_game
    expect(board.game_state).to eq(3)
  end
end