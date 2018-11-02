require 'yaml'
#Module - Behaviors - - - - - - - - 
module Game_functions
 def load_dictionary(word_file,dictionary)
   File.readlines(word_file).each do |line|
   dictionary << line
   end
   dictionary.keep_if { |word| word.length < 12 && word.length >5 }
 end

 def pick_a_word(words_array)
    random_number = rand(0...43786)
    selected_word = words_array[random_number]
    selected_word.chomp
 end

 def make_guessing_board(word)
    word_array = word.split('')
    masked_word = []
    word_array.length.times { masked_word << "_"}
    masked_word
 end

 def format_word_for_player(secret_word)
    guess_board_array = secret_word.split('')
    down_cased = guess_board_array.map {|letter| letter.downcase} 
 end

 def format_game_for_saving(game)
   # game_name = "#{game.player_name}"
   current_game = {
   	:player_name => "#{game.player_name}",
   	game_board: "#{game.game_board}",
   	guesses: "#{game.guesses}",
   	letters_guessed: "#{game.letters_guessed}",
   	secret_word: "#{game.secret_word}"
   }
 end	

 def save_game(game_obj,game_hash)
  Dir.mkdir("saved_games") unless Dir.exists?("saved_games")
  filename = "#{game_obj.player_name}.yml"
   File.open(filename,'w') do |file|
      file.puts YAML.dump(game_hash) 
   end 
 end

 def load_saved_game
   system('clear')
   puts ''
   puts ''
   puts 'what is your PLAYER name!?'
   get_file = gets.chomp
    
    if File.exist?("#{get_file}.yml")
      puts 'WE FOUND YOUR GAME:'
      saved_game = YAML.load_file("#{get_file}.yml")
      loaded_game = {
      	:player_name => saved_game[:player_name],
      	:game_board => saved_game[:game_board],
      	:guesses => saved_game[:guesses],
      	:letters_guessed => saved_game[:letters_guessed],
      	:secret_word => saved_game[:secret_word]
      }
      loaded_game
      p saved_game
    else
      puts'GAME NOT FOUND'
    end  	
 end

 def format_loaded_game_file(game_file)
   loaded_game = Hangman.new(game_file[:player_name],game_file[:secret_word])
   puts '- - - - - '
   loaded_game.game_board = game_file[:game_board]
   loaded_game.guesses = game_file[:guesses]
   loaded_game.letters_guessed = game_file[:letters_guessed]
   # puts "YOU GAME HAS BEEN LOADED: #{loaded_game.player_name}"
   loaded_game
  
 end

end 

 #objects - - - - - - - - - - - - 	

dictionary = []
list_of_words = "wordlist.txt"  

class Hangman
  include Game_functions
  attr_accessor :player_name, :game_board, :guesses, :letters_guessed,  :secret_word

  def initialize(player_name,secret_word)
    @player_name = player_name
    @game_board = []
    @guesses = 0
    @letters_guessed = []
    @secret_word = secret_word    
  end  
 end #end of class HANGMAN 


#script - - - - - -- - - - - - - -
include Game_functions
# - - - - - - - - - - - - - - - - - -
  ## -->WELCOME TO HANG MAN
  # --> PLAY? (y/n)
  system("clear")
  puts ''
  puts ''
  puts "***!! W_E_L_C_O_M_E to H-A-N-G-M-A-N-  !!***"
  puts "WOULD YOU LIKE TO PLAY? enter --->(y/n)"
  puts ''
  puts ''

  
  responses_valid = false
  while  responses_valid == false
  	user_response = gets.chomp

    if user_response == 'y'
      responses_valid = true
      system("clear")
      puts ''
      puts ''
      puts "(1)LOAD SAVED GAME? enter--> 1"
      puts "(2)PLAY NEW GAME?   enter--> 2"
      puts ''
      puts '' 
      
      user_input = false
      while user_input == false 
        load_or_save = gets.chomp

        if load_or_save == '1'
        #LOAD GAME PATH	
          user_input = true	
          #what is your user name? scrpit
          loaded_game = load_saved_game 
          current_game = format_loaded_game_file(loaded_game)
            if current_game.game_board.length < 1
               current_game.game_board = make_guessing_board(current_game.secret_word.join)
            end
             #PLAY LOADED GAME 
            system "clear"
            puts "YOU GAME HAS BEEN LOADED: #{current_game.player_name}" 
            puts 'A word had been selcted for you to guess:'
            puts ''
            puts ''
            puts "TYPE A LETTER IN, and THEN PRESS -->ENTER" 
            puts ''
            puts 'IF AT ANY TIME YOU WANT TO QUIT:: type in ---> - quit  -'
            puts 'IF YOU WANT TO GUESS THE WORD::   type in ---> - guess -'
            puts 'TO SAVE YOUR GAME AT ANY TIME::   type in ---> - save  -'
            
            while current_game.secret_word != current_game.game_board 
              puts 'MAKE A GUESS'
              guess = gets.chomp
            
                while current_game.letters_guessed.include?(guess)
                  puts '         YOU\'VE GUESSED THAT LETTER ALREADY--> TRY AGAIN:'
                  guess = gets.chomp
                end   
                 	
                if !current_game.letters_guessed.include?(guess)
            	  current_game.letters_guessed << guess               	   
                end 
                
                while !current_game.secret_word.include?(guess)
                	current_game.guesses += 1
                	system('clear')
                	puts "THERE IS NO ->#{guess.upcase} IN THIS WORD, TRY ANOTHER LETTER."
                	puts ''
                	puts "YOUR WORD: #{current_game.game_board}"
                	puts "LETTERS GUESSED SO FAR: #{current_game.letters_guessed}"
                	puts "NUMBER OF STRIKES: #{current_game.guesses}"
                	guess = gets.chomp
                end	

                if current_game.secret_word.include?(guess)
                   counter = 0
                   while counter < current_game.secret_word.length
                        if current_game.secret_word[counter]== guess
                   	      current_game.game_board[counter] = guess 
                        end
                       counter += 1
                    end
                 system('clear')
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
            end
          puts "YOU GUESSED IT WITH ONLY #{current_game.guesses} STRIKES! The secret word was #{current_game.secret_word.join}"
          puts 'WOULD YOU LIKE TO PLAY AGAIN??'


        elsif load_or_save == '2'
          #NEW GAME PATH	
          user_input = true
          dictionary = []
          # puts 'new'
          system('clear')
          puts ''
          puts 'ENTER YOUR PLAYER NAME:'
          name = gets.chomp
          list_of_words = "wordlist.txt"
          new_word = format_word_for_player(pick_a_word(load_dictionary(list_of_words,dictionary)))
          current_game = Hangman.new(name,new_word)
          current_game.game_board = make_guessing_board(new_word.join)
          # p current_game
            system('clear')
            puts 'A word had been selcted for you to guess:'
            puts ''
            puts ''
            puts "TYPE A LETTER IN, and THEN PRESS -->ENTER" 
            puts ''
            puts 'IF AT ANY TIME YOU WANT TO QUIT:: type in ---> - quit  -'
            puts 'IF YOU WANT TO GUESS THE WORD::   type in ---> - guess -'
            puts 'TO SAVE YOUR GAME AT ANY TIME::   type in ---> - save  -'
            
            while current_game.secret_word != current_game.game_board 
              puts 'MAKE A GUESS'
              guess = gets.chomp
            
                while current_game.letters_guessed.include?(guess)
                  puts '         YOU\'VE GUESSED THAT LETTER ALREADY--> TRY AGAIN:'
                  guess = gets.chomp
                end   
                 	
                if !current_game.letters_guessed.include?(guess)
            	  current_game.letters_guessed << guess               	   
                end 
                
                while !current_game.secret_word.include?(guess)
                	current_game.guesses += 1
                	system('clear')
                	puts "THERE IS NO ->#{guess.upcase} IN THIS WORD, TRY ANOTHER LETTER."
                	puts ''
                	puts "YOUR WORD: #{current_game.game_board}"
                	puts "LETTERS GUESSED SO FAR: #{current_game.letters_guessed}"
                	puts "NUMBER OF STRIKES: #{current_game.guesses}"
                	guess = gets.chomp
                end	

                if current_game.secret_word.include?(guess)
                   counter = 0
                   while counter < current_game.secret_word.length
                        if current_game.secret_word[counter]== guess
                   	      current_game.game_board[counter] = guess 
                        end
                       counter += 1
                    end
                 system('clear')
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
            end
          puts "YOU GUESSED IT WITH ONLY #{current_game.guesses} STRIKES! The secret word was #{current_game.secret_word.join}"
          puts 'WOULD YOU LIKE TO PLAY AGAIN??'


        else
          puts "INVALID ENTRY: ENTER -->'1' or -->'2'" 	 
        end 
      end#end of LOAD OR SAVE



    elsif user_response == 'n'
   	  responses_valid = true
      puts ''
      puts ''
      puts "OK WELL PLAY AGAIN NEXT TIME!"
      puts "BYE :) !"
      puts ''
      puts ''
    else
 	  puts "INVALID ENTRY: ENTER -->'y' or -->'n'"
  	  puts "youve entered: #{user_response}"
    end	
   end#end of responce valid loop
   		 	
  



  




