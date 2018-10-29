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

end
# - - - - - - - - - - - - - - - - -
#OBJECTS AND FILES AND CLASSES
 list_of_words = "wordlist.txt"

 class Hangman
  include Game_functions
  attr_accessor :game_board, :guesses, :letters_guessed, :random_words

  def initialize
    @game_board = []
    @guesses = 0
    @letters_guessed = []
    @random_words = []
  end  

 end #end of class HANGMAN 

  dictionary = []
 # game_board = []
 # guesses = 0
 # letters_guessed = []
 # random_words = []

# - - - - - - - - - - - - - - - - -

 list_of_words = "wordlist.txt"
# - - - - - - - - - - - - - - - - -
# - - - - - - - - - - - - - - - - -
#RUNNER SCRIPT
 include Game_functions
 


 #Load list of words
 # load_dictionary(list_of_words,dictionary)

 #create Instance of game
 # random_words << pick_a_word(dictionary)

#greet player
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

#initiate game
 response = gets.chomp
 if response == 'y'
   new_game = Hangman.new
   load_dictionary(list_of_words,dictionary)
   new_game.random_words << pick_a_word(dictionary)

   guess_word = new_game.random_words[0].chomp
   guess_word_array = guess_word.split('')
   down_cased = guess_word_array.map {|letter| letter.downcase} 
   #make gameboard
   new_game.game_board << make_guessing_board(guess_word)
   secret_word = new_game.game_board.flatten


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
   puts ''
   puts ''
   puts ''
   message = ''
   while secret_word != down_cased
   	 guess = gets.chomp
   	 if new_game.letters_guessed.include?(guess)
       puts '         YOU\'VE GUESSED THAT LETTER ALREADY--> TRY AGAIN:'
       guess = gets.chomp
     end  
       if !new_game.letters_guessed.include?(guess)
         counter = 0 
         while counter < down_cased.length
           if down_cased[counter] == guess
             secret_word[counter] = guess
           end 
           counter += 1 
         end
       end  
     new_game.letters_guessed << guess
     new_game.guesses += 1

     system "clear"
       if secret_word.include?(guess)
     	  message = "THERS IS AN -> #{guess.upcase} IN THIS WORD!"
       else
     	  message = "THERE IS NO ->#{guess.upcase} IN THIS WORD, TRY ANOTHER LETTER."
       end	
       	
     puts ''
     puts ''
     puts ''
     puts ''
     puts ''
     puts "           YOU GUESSED THE LETTER --> #{guess.upcase} "
     puts "           #{message}"
     puts ''
     puts ''
     puts "           YOUR WORD: #{secret_word}"
     puts ""
     puts "           NUMBER OF GUESSES: #{new_game.guesses}"
     puts ''
     puts "           LETTERS GUESSED SO FAR: #{new_game.letters_guessed}"
     puts ''
     puts ''
     puts ''
     # p secret_word
     # p guesses
     # p letters_guessed 
    end 
    answer = secret_word.join.upcase
    puts "           YOU GUESSED IT in #{new_game.guesses} guesses! The secret word was #{answer}"
    puts 
   # - - - - - - - - - -
 else
   puts 'Okay,maybe next time'  
 end




