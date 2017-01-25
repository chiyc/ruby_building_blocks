def Game
  def initialize
    @colors = [:R, :G, :B, :Y, :O, :P]
    @guess = []
    @clue = []
    @turn = 0
  end
  def display_state # 23 char
    puts
    puts "Decoding Board     Clue"
    puts "-----------------------"
    @guess.each_with_index do |guess, i|
      print "Guess #{i+1}: " + guess[i][0] + " " + guess[i][1] + " " + guess[i][2] + " " + guess[i][3] + " : "
      puts "#{@clue[i][0]}#{@clue[i][1]}#{@clue[i][2]}#{@clue[i][3]}"
    end
    puts
  end

  def start
    @code = @colors.sample(4)
  end
  
  def turn_prompt
    display_state
    slot = 1
    guess = []
    until guess.length == 4
      print "Please enter your input for slot #{guess.length + 1}: "
      valid_move = false
      until valid_move == true
        input = gets.chomp.upcase.to_sym
        valid_move = check(input)
        if valid_move == false
          print "Please enter a valid input for slot #{guess.length + 1}: "
        else
          guess.push(input)
        end
      end
    end
    @guess.push(guess)

    # next need to validate guesses and output display with updated display and decoding clue
  end

  def check(input)
    if colors.include?(input)
      return true
    else
      return false
    end
  end
end
