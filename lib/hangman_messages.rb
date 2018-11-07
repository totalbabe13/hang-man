
def welcome_to_hangman_message
  system("clear")
  puts ''
  puts ''
  puts "***!! W_E_L_C_O_M_E to H-A-N-G-M-A-N-  !!***"
  puts "WOULD YOU LIKE TO PLAY? enter --->(y/n)"
  puts ''
  puts ''
end	

def load_or_new_message
  system("clear")
  puts ''
  puts ''
  puts "(1)LOAD SAVED GAME? enter--> 1"
  puts "(2)PLAY NEW GAME?   enter--> 2"
  puts ''
  puts '' 
end  

def game_has_been_loaded_message(current_game)
  system "clear"
  puts ''
  puts ''
  puts "YOU GAME HAS BEEN LOADED: #{current_game.player_name}" 
  puts 'A word had been selcted for you to guess:'
  puts ''
  puts ''
  puts "TYPE A LETTER IN, and THEN PRESS -->ENTER" 
  puts ''
  puts 'IF AT ANY TIME YOU WANT TO QUIT:: type in ---> - quit  -'
  puts 'IF YOU WANT TO GUESS THE WORD::   type in ---> - guess -'
  puts 'TO SAVE YOUR GAME AT ANY TIME::   type in ---> - save  -'
end  

def letter_not_in_word_message(guess,current_game)
  system('clear')
  puts ''
  puts ''
  puts "#{current_game.player_name} GUESSED THE LETTER --> #{guess.upcase} "
  puts "THERE IS NO ->#{guess.upcase} IN THIS WORD, TRY ANOTHER LETTER."
  puts ''
  puts ''
  puts "YOUR WORD: #{current_game.game_board}"
  puts ''
  puts "LETTERS GUESSED SO FAR: #{current_game.letters_guessed}"
  puts ''
  puts "NUMBER OF STRIKES: #{current_game.guesses}"
end

def correct_letter_guessed_message(current_game,guess)
  system('clear')
  puts ''
  puts ''
  puts "#{current_game.player_name} GUESSED THE LETTER --> #{guess.upcase} "
  puts "THERS IS AN -> #{guess.upcase} IN THIS WORD!"
  puts ''
  puts ''
  puts "YOUR WORD: #{current_game.game_board}"
  puts ''
  puts "NUMBER OF STRIKES: #{current_game.guesses}"
  puts ''
  puts "LETTERS GUESSED SO FAR: #{current_game.letters_guessed}"  
end	  

def new_game_message
  system('clear')
  puts ''
  puts ''
  puts 'A word had been selcted for you to guess:'
  puts ''
  puts ''
  puts "TYPE A LETTER IN, and THEN PRESS -->ENTER" 
  puts ''
  puts 'IF AT ANY TIME YOU WANT TO QUIT:: type in ---> - quit  -'
  puts 'IF YOU WANT TO GUESS THE WORD::   type in ---> - guess -'
  puts 'TO SAVE YOUR GAME AT ANY TIME::   type in ---> - save  -'
end

def play_again_message(current_game)
  puts ''
  puts ''
  puts "YOU GUESSED IT WITH ONLY #{current_game.guesses} STRIKES! The secret word was --> #{current_game.secret_word.join.upcase}"
  puts 'WOULD YOU LIKE TO PLAY AGAIN??'
end  

def run_game(current_game)
  while current_game.secret_word != current_game.game_board 
              puts ' MAKE A GUESS'
              puts ' ---' 
              guess = gets.chomp
            
                while current_game.letters_guessed.include?(guess)
                  puts '         YOU\'VE GUESSED THAT LETTER ALREADY--> TRY AGAIN:'
                  guess = gets.chomp
                end   
                 	
                if !current_game.letters_guessed.include?(guess)
            	  current_game.letters_guessed << guess               	   
                end 
                
                if !current_game.secret_word.include?(guess)
                	current_game.guesses += 1
                	letter_not_in_word_message(guess,current_game)
                end	
                

                if current_game.secret_word.include?(guess)
                   counter = 0
                   while counter < current_game.secret_word.length
                        if current_game.secret_word[counter]== guess
                   	      current_game.game_board[counter] = guess 
                        end
                       counter += 1
                    end
                  correct_letter_guessed_message(current_game,guess)   
                end	

            end
end	