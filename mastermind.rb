class Game
  def initialize
    @colors = [:R, :G, :B, :Y, :O, :P]
    @guess = []
    @clue = []
    @turn = 0
    @game_state = 0
  end
  def display_state # 23 char
    puts
    puts "          Decoding Board     Clue"
    puts "         -----------------------"
    @guess.each_with_index do |guess, i|
      if i < 9
        print " "
      end
      print "Guess #{i+1}:  " + guess[0] + "   " + guess[1] + "   " + guess[2] + "   " + guess[3] + "   :  "
      puts "#{@clue[i][0]}#{@clue[i][1]}"
      puts "                              #{@clue[i][2]}#{@clue[i][3]}"
      puts
    end
  end

  def start
    @code = @colors.sample(4)
    p @code
    puts "Secret code initialized."
    display_state
    until @game_state != 0
      turn_prompt
      display_state
      check_game
    end
    if @game_state == 1
      puts "Congratulations! You broke the code!"
    elsif @game_state == 2
      puts "You couldn't break the code in time!"
    end
  end

  def check_game
    if @clue.length == 12
      @game_state = 2
    end
    if @clue[-1].all? { |c| c == "o" }
      @game_state = 1
    end 
  end
  
  def turn_prompt
    slot = 1
    guess = []
    until guess.length == 4
      print "Please enter your input for slot #{guess.length + 1}: "
      valid_move = false
      until valid_move == true
        input = gets.chomp.upcase
        input_check = input.to_sym
        valid_move = check(input_check)
        if valid_move == false
          print "Please enter a valid input for slot #{guess.length + 1}: "
        else
          guess.push(input)
        end
      end
    end
    @guess.push(guess)
    validate(guess)
    # next need to validate guesses and output display with updated display and decoding clue
  end

  def validate(guess)
    code_check = @code.clone
    guess_check = guess.map { |x| x.to_sym }
    clue = []
    guess_check.each_with_index do |g, i|
      if g == code_check[i]
        guess_check[i] = '-'
        code_check[i] = nil
        clue.push('o')
      end
    end
    guess_check.each_with_index do |g, i|
      if code_check.include?(g)
        guess_check[i] = '-'
        code_check[code_check.find_index(g)]
        clue.push('x')
      end
    end
    until clue.length == 4
      clue.push('-')
    end
    @clue.push(clue)
  end

  def check(input)
    if @colors.include?(input)
      return true
    else
      return false
    end
  end
end

game = Game.new
game.start
