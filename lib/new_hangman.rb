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
    else
      puts'GAME NOT FOUND'
    end  	
 end		

end 

 #objects - - - - - - - - - - - - 	

dictionary = []
list_of_words = "wordlist.txt"  

class Hangman
  include Game_functions
  attr_accessor :game_board, :guesses, :letters_guessed, :player_name, :secret_word

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

# load_dictionary(list_of_words,dictionary)
# test_word = format_word_for_player(pick_a_word(dictionary))
# p x                         --> #"riffraff"
# p make_guessing_board(x)    --> #["_", "_", "_", "_", "_", "_", "_", "_"]
# p format_word_for_player(x) -->#["r", "i", "f", "f", "r", "a", "f", "f"]
# new_game = Hangman.new('Leonardo7', test_word)
# p new_game.secret_word.join
# x = format_game_for_saving(new_game)
# save_game(new_game, x)
# thing = YAML.load_file("Leonardo7.yml")
#  puts thing.inspect
# p thing[:player_name]


  test_game = load_saved_game 
  
  loaded_game =Hangman.new(test_game[:player_name],test_game[:secret_word])
  p loaded_game
  




