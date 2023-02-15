require_relative '../music_album'
require_relative 'genre'
require_relative 'color'
require 'json'
class MusicAlbumModule
  include ColorTerminal

  def initialize(labels, authors, genres)
    @music_albums = load_music_albums
    @genres = genres
    @labels = labels
    @authors = authors
  end

  def load_music_albums
    return [] if File.read(File.join('data', 'music_album.json')).empty?

    JSON.parse(File.read(File.join('data', 'music_album.json')))
  end

  def list_all_music_albums
    return puts red('There are no music albums in the catalog') if @music_albums.empty?

    puts 'Music albums are: '
    @music_albums.each do |music_album|
      puts "Title: #{blue(music_album['title'])}, Artist: #{blue(music_album['artist'])}, " \
           "Genre: #{blue(@genres.get_genre(music_album['genre_id']))}"
    end
  end

  def get_user_string(msg)
    print cyan(msg)
    gets.chomp
  end

  def get_user_genre(msg)
    @genres.list_all_genres
    print msg
    index = gets.chomp.to_i
    if index <= @genres.genres.length && index.positive?
      @genres.genres[index - 1]
    else
      puts red('Invalid index')
      get_user_genre(msg)
    end
  end

  def music_album_exists?(_music_album)
    @music_albums.any? { |music_album| music_album['title'] == music_album }
  end

  def get_user_label(msg)
    @labels.list_all_labels
    print msg
    index = gets.chomp.to_i
    if index <= @labels.labels.length && index.positive?
      @labels.labels[index - 1]
    else
      puts red('Invalid index')
      get_user_label(msg)
    end
  end

  # Prompts the user to choose a game author from a list
  def get_user_author(msg)
    @authors.list_all_authors
    print msg
    index = gets.chomp.to_i
    if index <= @authors.authors.length && index.positive?
      @authors.authors[index - 1]
    else
      puts red('Invalid index')
      get_user_author(msg)
    end
  end

  def add_music_album
    on_spotify = get_user_string('Is music album avaliable on spotify(y/n): ')
    on_spotify = true if on_spotify.downcase == 'y'
    publish_date = get_user_string('Enter published date(yyyy-mm-dd): ')
    genre = get_user_genre('Enter music album genre: ')
    label = get_user_label('Choose Label: ')
    author = get_user_author('Choose author: ')
    label = Label.new(label['title'], label['color'], label['id'])
    author = Author.new(author['first_name'], author['last_name'], author['id'])
    genre = Genre.new(genre['id'], genre['name'])
    music_album = MusicAlbum.new(on_spotify, publish_date)
    music_album.genre = genre
    music_album.label = label
    music_album.author = author
    @music_albums << music_album.to_hash
    write_music_album_to_file
  end

  def write_music_album_to_file
    music_album_file_path = File.join('data', 'music_album.json')
    File.write(music_album_file_path, JSON.pretty_generate(@music_albums))
  end
end
