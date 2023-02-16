require_relative 'helper_module'
class MusicAlbumModule
  include Selection
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
      puts "On Spotify: #{blue(music_album['on_spotify'])}, Publish Date: #{blue(music_album['publish_date'])}, " \
           "Author: #{blue(@authors.get_author_full_name(music_album['author_id']))}, " \
           "Genre: #{blue(@genres.get_genre(music_album['genre_id']))}, " \
           "Label: #{blue(@labels.get_label(music_album['label_id']))}."
    end
  end

  def music_album_exists?(_music_album)
    @music_albums.any? { |music_album| music_album['title'] == music_album }
  end

  def add_music_album
    on_spotify = get_user_string('Is music album avaliable on spotify(y/n): ')
    on_spotify = on_spotify.downcase == 'y'
    publish_date = get_user_date('Enter published date(yyyy-mm-dd): ')
    genre = get_user_genre('Enter music album genre: ', @genres)
    label = get_user_label('Choose Label: ', @labels)
    author = get_user_author('Choose author: ', @authors)
    label = Label.new(label['title'], label['color'], label['id'])
    author = Author.new(author['first_name'], author['last_name'], author['id'])
    genre = Genre.new(genre['name'], genre['id'])
    music_album = MusicAlbum.new(on_spotify, publish_date)
    music_album.genre = genre
    music_album.label = label
    music_album.author = author
    @music_albums << music_album.to_hash
    write_music_album_to_file
    puts green('Music Album added successfully')
  end

  def write_music_album_to_file
    music_album_file_path = File.join('data', 'music_album.json')
    File.write(music_album_file_path, JSON.pretty_generate(@music_albums))
  end
end
