require_relative '../game'
require_relative '../author'
require_relative '../label'
require_relative 'color'
require 'time'
require 'json'

# A module for handling game data
class GameModule
  include ColorTerminal

  def initialize(label, author)
    @games = load_games
    @label = label
    @author = author
  end

  attr_accessor :games

  # Loads game data from JSON file
  def load_games
    games_file_path = File.join('data', 'games.json')
    return [] if File.read(games_file_path).empty?

    JSON.parse(File.read(games_file_path))
  end

  # Lists all games in the catalog
  def list_all_games
    if @games.empty?
      puts 'There are no games in the catalog'
    else
      puts 'Games are: '
      @games.each do |game|
        puts "Multiplayer: #{blue(game['multiplayer'])}, Last played: #{blue(game['last_played'])} " \
             "Publish date: #{blue(game['publish_date'])}"
      end
    end
  end

  # Prompts the user for a string input
  def get_user_string(msg)
    print cyan(msg)
    gets.chomp
  end

  # Handles user input for multiplayer status
  def multiplayer_handler(cover_state)
    return 'yes' if cover_state.downcase == 'y'

    'no'
  end

  # Checks if a given string is a valid date
  def valid_time?(date_string)
    Time.parse(date_string)
    true
  rescue ArgumentError
    false
  end

  # Prompts the user for a valid date
  def get_user_date(msg)
    time = get_user_string(msg)
    if valid_time?(time)
      time
    else
      puts red('Invalid date')
      get_user_date(msg)
    end
  end

  # Prompts the user to choose a game label from a list
  def get_user_label(msg)
    @label.list_all_labels
    print msg
    index = gets.chomp.to_i
    if index <= @label.labels.length && index.positive?
      @label.labels[index - 1]
    else
      puts red('Invalid index')
      get_user_label(msg)
    end
  end

  # Prompts the user to choose a game author from a list
  def get_user_author(msg)
    @author.list_all_authors
    print msg
    index = gets.chomp.to_i
    if index <= @author.authors.length && index.positive?
      @author.authors[index - 1]
    else
      puts red('Invalid index')
      get_user_author(msg)
    end
  end

  # Adds a new game to the catalog
  def add_game
    puts 'Please enter the following information'

    multiplayer = multiplayer_handler(get_user_string('Multiplayer (y/n): '))
    last_played = get_user_date('Last played (yyyy-mm-dd): ')
    publish_date = get_user_date('Publish date (yyyy-mm-dd): ')
    label = get_user_label('Choose label: ')
    author = get_user_author('Choose author: ')
    game = Game.new(multiplayer, last_played, publish_date)
    author = Author.new(author['first_name'], author['last_name'])
    label = Label.new(label['title'], label['color'])
    game.label = label
    game.author = author
    @games << game.to_hash
    write_games_to_file
    puts green('Game added successfully')
  end

  # Writes game data to JSON file
  def write_games_to_file
    games_file_path = File.join('data', 'games.json')
    File.write(games_file_path, JSON.pretty_generate(@games))
  end
end
