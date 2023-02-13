require_relative 'helper'

class App
    def initialize
        @books = BookModule.new
    end

    attr_accessor :books
    def user_menu
        puts " "
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
        puts " "
    end
    def run()
        user_menu
        print("Please enter a number:")
        user_input = gets.chomp.to_i
        case user_input
        when 1
            list_books
        when 2
            list_all_music_albums
        when 3
            list_all_movies
        when 4
            list_all_games
        when 5
            list_all_genres
        when 6
            list_all_labels
        when 7
            list_all_authors
        when 8
            list_all_sources
        when 9
            add_a_book
        when 10
            add_a_music_album
        when 11
            add_a_movie
        when 12
            add_a_game
        when 13
            "leave the catalog"
        end
        return nil if user_input == 13
        run
    end

    def list_books
        @books.send(:list_all_books)
    end

    def add_a_book
        @books.send(:add_book)
    end
end