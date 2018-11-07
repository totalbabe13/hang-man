require 'yaml'
require_relative 'hangman_messages'


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
# - - - - - - - - - - - - - - - - -
  welcome_to_hangman_message #MESSAGE INTERFACE
 
  responses_valid = false
  while  responses_valid == false
  	user_response = gets.chomp
    if user_response == 'y'
      responses_valid = true
      load_or_new_message #MESSAGE INTERFACE
      user_input = false
      
      while user_input == false 
        load_or_save = gets.chomp
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
        #LOAD GAME PATH	
        if load_or_save == '1'
          user_input = true	
          loaded_game = load_saved_game 
          current_game = format_loaded_game_file(loaded_game)
            if current_game.game_board.length < 1
               current_game.game_board = make_guessing_board(current_game.secret_word.join)
            end
             #PLAY LOADED GAME # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
          game_has_been_loaded_message(current_game) 
          run_game(current_game)
          play_again_message(current_game)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
        elsif load_or_save == '2'
        #NEW GAME PATH	
          user_input = true
          dictionary = []
 
          system('clear')
          puts ''
          puts 'ENTER YOUR PLAYER NAME:'
          name = gets.chomp

          list_of_words = "wordlist.txt"
          new_word = format_word_for_player(pick_a_word(load_dictionary(list_of_words,dictionary)))
          current_game = Hangman.new(name,new_word)
          current_game.game_board = make_guessing_board(new_word.join)
          new_game_message
           #PLAY NEW GAME # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -   
          run_game(current_game)
          play_again_message(current_game)
          
        else
          puts "INVALID ENTRY: ENTER -->'1' or -->'2'" 	 
        end 
      end#end of LOAD OR SAVE

    elsif user_response == 'n'
   	  responses_valid = true
      puts ''
      puts ''
      puts "OK WE'LL PLAY NEXT TIME!"
      puts "BYE :) !"
      puts ''
      puts ''
    else
 	  puts "INVALID ENTRY: ENTER -->'y' or -->'n'"
  	  puts "youve entered: #{user_response}"
    end	
   end#end of responce valid loop
   		 	
  



  




