# When a new game is started, your script should load in the dictionary and randomly 
# select a word between 5 and 12 characters long for the secret word.

# display some sort of count so the player knows how many more incorrect guesses 
# he/she has before the game ends. You should also display which correct letters 
# have already been chosen (and their position in the word, e.g. _ r o g r a _ _ i n g) 
# and which incorrect letters have already been chosen.
# Every turn, allow the player to make a guess of a letter. 

# It should be case insensitive. Update the display to reflect whether the letter was 
# correct or incorrect. If out of guesses, the player should lose.
# Now implement the functionality where, at the start of any turn, 
# instead of making a guess the player should also have the option 
# to save the game. Remember what you learned about serializing objects… 
# you can serialize your game class too!

# When the program first loads, add in an option that allows you to open one of your saved games,
#  which should jump you exactly back to where you were when you saved. Play on!

#   - - - - - - - - - - - - - - - - -
# # - - - - - - - - - - - - - - - - -
#BEHAVIOR AND METHODS

module Game_functions

  def load_dictionary(word_file,dictionary)
   File.readlines(word_file).each do |line|
   dictionary << line
   end
   dictionary.keep_if { |word| word.length < 12 && word.length >5 }
  end 

  def pick_a_word(words)
    random_number = rand(0...43786)
    selected_word = words[random_number]
    selected_word
  end	

  def make_guessing_board(word)
    word_array = word.split('')
    masked_word = []
    word_array.length.times { masked_word << "_"}
    masked_word
  end

  def format_word_for_player(new_game.word_array)
    guess_word = new_game.word_array[0].chomp
    guess_word_array = guess_word.split('')
    down_cased = guess_word_array.map {|letter| letter.downcase} 
  end  

  def greet_player
    system "clear"
    puts ''
    puts ''
    puts ''
    puts ''
    puts 'WELCOME to H_A_N_G_M_A_N'
    puts '------- -- -------------'
    puts ''
    puts ''
    puts ''
    puts ''
    puts 'Would you like to play HANGMAN?  (y/n):'
  end

  def save_or_load
    system "clear"
    puts ''
    puts ''
    puts ''
    puts ''
    puts ' DO YOU WANT TO:'
    puts ' PRESS:(1) --> START NEW GAME'
    puts ' OR'
    puts ' PRESS:(2) --> LOAD A SAVED GAME?'
    puts ''
    puts ''
    puts ''
  end 

  def get_user_name
    system "clear"
    puts ''
    puts ''
    puts ''
    puts ''
    puts ''
    puts ''
    puts '            PLEASE ENTER YOUR NAME AND PRESS ENTER:'
    puts ''
    puts ''
    puts ''
    puts ''
  end

  def select_a_letter
      system "clear"
      puts ''
      puts ''
      puts ''
      puts ''
      puts '          A word had been selcted for you to guess:'
      puts ''
      puts ''
      puts ''
      puts ''
      puts ''
      puts "         TYPE A LETTER IN, and THEN PRESS -->ENTER" 
      puts ''
      puts '         IF AT ANY TIME YOU WANT TO QUIT:: type in ---> - quit -'
      puts '         IF YOU WANT TO GUESS THE WORD::   type in ---> - guess -'
      puts '         TO SAVE YOUR GAME AT ANY TIME::   type in ---> - save - '
  end 

  def current_game_status(new_game,guess,message,secret_word)
      puts ''
      puts ''
      puts ''
      puts ''
      puts ''
      puts "           #{new_game.player_name} GUESSED THE LETTER --> #{guess.upcase} "
      puts "           #{message}"
      puts ''
      puts ''
      puts "           YOUR WORD: #{secret_word}"
      puts ''
      puts "           NUMBER OF GUESSES: #{new_game.guesses}"
      puts ''
      puts "           LETTERS GUESSED SO FAR: #{new_game.letters_guessed}"
      puts ''
      puts ''
      puts ''
  end  

end
# - - - - - - - - - - - - - - - - -
#OBJECTS AND FILES AND CLASSES
 list_of_words = "wordlist.txt"

 class Hangman
  include Game_functions
  attr_accessor :game_board, :guesses, :letters_guessed, :random_words, :player_name

  def initialize(player_name)
    @player_name = player_name
    @game_board = []
    @guesses = 0
    @letters_guessed = []
    @random_words = []
  end  
  

 end #end of class HANGMAN 

  dictionary = []
  list_of_words = "wordlist.txt"
# - - - - - - - - - - - - - - - - -

#RUNNER SCRIPT
 include Game_functions
 greet_player#USER MESSAGE




#SAVE or LOAD game?
 response = gets.chomp
 if response == 'y'
   save_or_load#USER MESSAGE
   user_response = gets.chomp
    
    if user_response == '1'
      get_user_name#USER MESSAGE
      new_player = gets.chomp
      new_game = Hangman.new(new_player)


   #Find word from text file/ format it for game play
      load_dictionary(list_of_words,dictionary)
      new_game.random_words << pick_a_word(dictionary)
      format_word_for_player(new_game.random_words)
   
   #Make new gameboard attribute
      new_game.game_board << make_guessing_board(guess_word)
      secret_word = new_game.game_board.flatten
      select_a_letter#USER MESSAGE
      message = '' #info for user Message Toggle 

    #game WHILE loop:  
      while secret_word != down_cased
   	    guess = gets.chomp

        #If you'd already guessed a letter:
   	    if new_game.letters_guessed.include?(guess)
          puts '         YOU\'VE GUESSED THAT LETTER ALREADY--> TRY AGAIN:'
          guess = gets.chomp
        end  
  
        #If you guessed a NEW letter:
        if !new_game.letters_guessed.include?(guess)
          counter = 0
        #CHECK to see if GUESS matches any characters in secret word:
          while counter < down_cased.length
            if down_cased[counter] == guess
        #FIND the INDEX of the matched Charcter and replace it:      
             secret_word[counter] = guess 
            end 
            counter += 1 
          end  
        end  
      #store guessed letters and number of guesses:  
      new_game.letters_guessed << guess
      # new_game.guesses += 1
      system "clear"
        
        if secret_word.include?(guess)
     	    message = "THERS IS AN -> #{guess.upcase} IN THIS WORD!"
        else
     	    message = "THERE IS NO ->#{guess.upcase} IN THIS WORD, TRY ANOTHER LETTER."
        end	
      #update PLAYER on the STATUS of thier current GAME:  
      current_game_status(new_game,guess,message,secret_word) 	
    end #CLOSES GAME WHILE LOOP

   # - - - - - - - - -
   #IF the PLAYER SOLVES the word:

    answer = secret_word.join.upcase
    puts "           YOU GUESSED IT in #{new_game.guesses} guesses! The secret word was #{answer}"
    puts '            WOULD YOU LIKE TO PLAY AGAIN??'



  end #closes new game IF statement path of NEW GAME
   # - - - - - - - - - -
 else
   puts 'Okay,maybe next time'  
 end




