
class Hangman
  def initialize
    @word = ""
    @progress = ""
    @guess = ""
    @guesses_remaining = 10
    @incorrect_letters = []
    @correct_letters = []
    @words_attempted = []
    @game_end = 0
  end

  def start
    if File.exist?("hangman.save")
      input = ""
      until input == "y" || input == "n"
        print "A saved game exists. Do you wish to load from file? (y/n) "
        input = gets.chomp.downcase
      end
      if input == "y"
        saved_objects = Marshal.load(File.read("hangman.save"))

        puts saved_objects
        @word = saved_objects[0]
        @progress = saved_objects[1]
        @guess = saved_objects[2]
        @guesses_remaining = saved_objects[3]
        @incorrect_letters = saved_objects[4]
        @correct_letters = saved_objects[5]
        @words_attempted = saved_objects[6]
        @game_end = 0
      elsif input == "n"
        new_word
      end
    end

    until @game_end != 0
      puts
      display_state
      puts
      prompt_guess
      process_guess
    end

    if @game_end == 1 # game won
      display_state
      puts
      puts "Congratulations! You won!"
      File.delete("hangman.save")
    elsif @game_end == 2 # game lost
      display_state
      puts "Nice try! The correct word was '#{@word}'"
      File.delete("hangman.save")
    elsif @game_end == 3
      puts
      save_game
      puts "Game saved."
      puts
      puts "Thanks for playing. See you next time!"
    end
  end

  def save_game
    save_file = File.new("hangman.save", "w")
    saved_objects = [@word, @progress, @guess, @guesses_remaining,
                     @incorrect_letters, @correct_letters, @words_attempted,
                     @game_end]
    Marshal.dump(saved_objects,save_file)
    save_file.close
  end

  def display_state
    puts "             Word: #{@progress.gsub(/(\w)/, '\1 ')}"
    
    puts "  Correct guesses: #{@correct_letters.join(', ')}"
    puts "Incorrect guesses: #{@incorrect_letters.join(', ')}"
    puts "    Words guessed: #{@words_attempted.join(', ')}"
    display_remaining_guesses
  end

  def process_guess
    if @guess == ":wq"
      @game_end = 3
      return nil
    end

    if @guess.length == 1
      if @word.include?(@guess)
        @correct_letters.push(@guess)
        index = 0
        @word.each_char do |letter|
          if @guess == letter
            @progress[index] = @guess
          end
          index += 1
        end
        if @progress == @word
          @game_end = 1
        end
      else
        @incorrect_letters.push(@guess)
        @guesses_remaining -= 1
      end

    elsif @guess.length == @word.length
      if @guess == @word
        @game_end = 1
      else
        @words_attempted.push(@guess)
        @guesses_remaining -= 1
      end
    end

    if @guesses_remaining == 0
      @game_end = 2
    end

  end

  def prompt_guess
    valid_input = false
    puts "Enter ':wq' to save and quit at any time."
    until valid_input
      print "Please enter a guess: "
      input = gets.chomp.downcase
      valid_input = validate_guess(input)
    end
  end

  def validate_guess(guess)
    if guess == ":wq"
      @guess = guess
      return true
    end

    already_guessed = @correct_letters.include?(guess) || @incorrect_letters.include?(guess) || @words_attempted.include?(guess) ? true : false    
    if already_guessed
      puts "Guess has already been attempted."
      puts
      return false
    elsif guess.length == 1
      @guess = guess
      return true
    elsif guess.length == @word.length
      @guess = guess
      return true
    else
      puts "Input is an invalid length."
      puts
      return false
    end
  end

  def new_word
    word_list = []
    File.foreach("5desk.txt") do |line|
      word = line.strip
      if word.length >= 5 && word.length < 13
        word_list.push(word.downcase)
      end
    end
    @word = word_list.sample
    @progress = "".ljust(@word.length, '_')
    p @word
    p @progress
    puts
  end

  def display_remaining_guesses
    puts "Remaining guesses: #{@guesses_remaining}"
  end
end

game = Hangman.new
game.start
