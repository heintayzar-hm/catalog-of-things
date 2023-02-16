require_relative 'helper_module'

# A module for handling game data
class GameModule
  include Selection
  include ColorTerminal

  def initialize(label, author, genre)
    @games = load_games
    @labels = label
    @authors = author
    @genres = genre
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
        puts "Multiplayer: #{blue(game['multiplayer'])}, Last played: #{blue(game['last_played'])}, " \
             "Publish date: #{blue(game['publish_date'])}, " \
             "Author: #{blue(@authors.get_author_full_name(game['author_id']))}, " \
             "Genre: #{blue(@genres.get_genre(game['genre_id']))}, " \
             "Label: #{blue(@labels.get_label(game['label_id']))}."
      end
    end
  end

  # Handles user input for multiplayer status
  def multiplayer_handler(cover_state)
    return 'yes' if cover_state.downcase == 'y'

    'no'
  end

  # Adds a new game to the catalog
  def add_game
    puts 'Please enter the following information'

    multiplayer = multiplayer_handler(get_user_string('Multiplayer (y/n): '))
    last_played = get_user_date('Last played (yyyy-mm-dd): ')
    publish_date = get_user_date('Publish date (yyyy-mm-dd): ')
    label = get_user_label('Choose label: ', @labels)
    author = get_user_author('Choose author: ', @authors)
    genre = get_user_genre('Choose genre: ', @genres)
    game = Game.new(multiplayer, last_played, publish_date)
    author = Author.new(author['first_name'], author['last_name'], author['id'])
    label = Label.new(label['title'], label['color'], label['id'])
    genre = Genre.new(genre['name'], genre['id'])
    game.label = label
    game.author = author
    game.genre = genre
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
