require_relative 'helper'

class App
  def initialize
    @labels = LabelModule.new
    @authors = AuthorModule.new
    @genres = GenreModule.new
    @books = BookModule.new(@labels, @authors)
    @games = GameModule.new(@labels, @authors)
    @music_albums = MusicAlbumModule.new(@genres)
  end

  attr_accessor :books

  def user_menu
    puts ' '
    puts 'Welcome to the Catalog of Things'
    puts "Please Chose the following options:
                    1. List all books
                    2. List all music albums
                    3. List all movies
                    4. List of games
                    5. List all genres
                    6. List all labels
                    7. List all authors
                    8. List all sources
                    9. Add a book
                    10. Add a music album
                    11. Add a movie
                    12. Add a game
                    13. Leave the catalog"
    puts ' '
  end

  def user_choice(user_input)
    @options = [
      { user_choice: 1, action: :list_books },
      { user_choice: 2, action: :list_all_music_albums },
      { user_choice: 3, action: :list_all_movies },
      { user_choice: 4, action: :list_all_games },
      { user_choice: 5, action: :list_all_genres },
      { user_choice: 6, action: :list_all_labels },
      { user_choice: 7, action: :list_all_authors },
      { user_choice: 8, action: :list_all_sources },
      { user_choice: 9, action: :add_a_book },
      { user_choice: 10, action: :add_a_music_album },
      { user_choice: 11, action: :add_a_movie },
      { user_choice: 12, action: :add_a_game }
    ]
    action = @options.find { |option| option[:user_choice] == user_input }&.[](:action)
    send(action) if action

    run
  end

  def run()
    user_menu
    print('Please enter a number:')
    user_input = gets.chomp.to_i
    return puts 'leave the catalog' if user_input >= 13

    user_choice(user_input)
  end

  def list_all_games
    @games.send(:list_all_games)
  end

  def add_a_game
    @games.send(:add_game)
  end

  def list_all_authors
    @authors.send(:list_all_authors)
  end

  def list_books
    @books.send(:list_all_books)
  end

  def add_a_book
    @books.send(:add_book)
  end

  def list_all_labels
    @labels.send(:list_all_labels)
  end

  def add_a_music_album
    @music_albums.send(:add_music_album)
  end
end
