require 'connect_four.rb'

describe "connect four" do
  let(:game) { ConnectFour.new}
  
  describe "#initialize" do
    it "creates new board" do
      expect(game.board).to be_a(Board)
    end
    it "starts with empty board" do
      expect(game.board.board).to eq(Array.new(7, Array.new(6,0)))
    end

  end

  describe "#check(move)" do
    it "forbids invalid column move input" do
      expect(game.board.check("sd")).to be false
      expect(game.board.check("-1")).to be false
      expect(game.board.check("7")).to be false
      expect(game.board.check("7")).to be false
      expect(game.board.check("")).to be false
      expect(game.board.check("132")).to be false
    end
    it "forbids move in full column" do
      game.board.board[2].each_with_index { |x, i| game.board.board[2][i] = 1 }
      expect(game.board.check('2')).to be false
      expect(game.play('2')).to be false
    end
  end
  
  context "playing a move" do
    describe "board" do
      it "recognizes full target columns" do
        game.board.board[2].each_with_index { |x, i| game.board.board[2][i] = 1 }
        expect(game.board.is_full?(2)).to be true
      end
    end

    it "drops first piece into selected column" do
      game.play('3')
      expect(game.board.board[3][0]).to eq(1)
    end

    it "changes current player to next player" do
      expect(game.play('4')).to be true
      expect(game.current_player).to eq(2)
      expect(game.play('1')).to be true
      expect(game.current_player).to eq(1)
    end

    it "correctly drops next piece on top of first piece" do
      expect(game.play('3')).to be true
      expect(game.play('3')).to be true
      expect(game.board.board[3][1]).to eq(2)
    end

  end
end