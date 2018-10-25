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


# - - - - - - - - - - - - - - - - -
#OBJECTS AND FILES AND CLASSES

 list_of_words = "wordlist.txt"

 dictionary = []
 game_board = []
 guesses = 0
 letters_guessed = []
 
# - - - - - - - - - - - - - - - - -
#BEHAVIOR AND METHODS

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
# - - - - - - - - - - - - - - - - -
#RUNNER SCRIPT

# load_dictionary(list_of_words,dictionary)
# pick_a_word(dictionary)
# TODO STILL:
# downcase the secret word

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
 puts 'Would you like to play?  (y/n):'

#initiate game
 response = gets.chomp
 if response == 'y'
   test_word = 'Bananas'
   test_word_array = test_word.split('')
   down_cased = test_word_array.map {|letter| letter.downcase} 
   
   #make gameboard
   game_board << make_guessing_board(test_word)
   secret_word = game_board.flatten


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
   
   while secret_word != down_cased
   	 guess = gets.chomp
   	 if letters_guessed.include?(guess)
   	   message = " THERS IS AN #{guess.upcase}'" 
       puts '         you\'ve guessed that already'
       guess = gets.chomp
     end  
       if !letters_guessed.include?(guess)   
         counter = 0 
         while counter < down_cased.length
           if down_cased[counter] == guess
             secret_word[counter] = guess    
           end 
           counter += 1 
         end
       end  
     letters_guessed << guess
     guesses += 1 
     puts ' - - - - -'
     system "clear"
     puts ''
     puts ''
     puts ''
     puts ''
     puts ''
     puts ''
     puts "           YOU GUESSED THE LETTER #{guess}"
     puts ''
     puts ''
     puts "           YOUR WORD: #{secret_word}"
     puts ''
     puts "           NUMBER OF GUESSES: #{guesses}"
     puts ''
     puts "           LETTERS GUESSED SO FAR: #{letters_guessed}"
     puts ''
     puts ''
     puts ''
     # p secret_word
     # p guesses
     # p letters_guessed 
    end 
    answer = secret_word.join.upcase
    puts "           YOU GUESSED IT in #{guesses} guesses! The secret word was #{answer}"
    puts 
   # - - - - - - - - - -
 else
   puts 'Okay,maybe next time'  
 end




