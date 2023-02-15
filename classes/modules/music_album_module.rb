require_relative '../music_album'
require_relative 'color'
require 'json'
class MusicAlbumModule
  include ColorTerminal

  def initialize(genres)
    @music_albums = load_music_albums
    @genres = genres
  end

  def load_music_albums
    return [] if File.read(File.join('data', 'music_albums.json')).empty?

    JSON.parse(File.read(File.join('data', 'music_albums.json')))
  end

  def list_all_music_albums
    return puts red('There are no music albums in the catalog') if @music_albums.empty?
      puts 'Music albums are: '
      @music_albums.each do |music_album|
        puts "Title: #{blue(music_album['title'])}, Artist: #{blue(music_album['artist'])}, " \
             "Genre: #{blue(@genres.get_genre(music_album['genre_id']))}"

  end

  def get_user_string(msg)
      print cyan(msg)
      gets.chomp
  end

  def get_user_genre(msg)
      genre = get_user_string(msg)
      if @genres.genre_exists?(genre)
        genre
      else
        puts red('Invalid genre')
        get_user_genre(msg)
      end
  end

    def get_user_music_album(msg)
      music_album = get_user_string(msg)
      if music_album_exists?(music_album)
        music_album
      else
        puts red('Invalid music album')
        get_user_music_album(msg)
      end
    end

    def music_album_exists?(_music_album)
      @music_albums.any? { |music_album| music_album['title'] == music_album }
    end

    def add_music_album
      title = get_user_string('Enter music album title: ')
      artist = get_user_string('Enter music album artist: ')
      genre = get_user_genre('Enter music album genre: ')
      @music_albums << MusicAlbum.new(title, artist, genre).to_hash
      save_music_albums
    end

    def write_music_album_to_file
      music_album_file_path = File.join('data', 'music_albums.json')
      File.write(music_album_file_path, JSON.pretty_generate(@music_albums))
    end
  end
end
