require_relative 'helper_module'
class BookModule
  include Selection
  include ColorTerminal

  def initialize(labels, authors, genres)
    @books = load_books
    @labels = labels
    @authors = authors
    @genres = genres
  end

  attr_accessor :books

  def load_books
    return [] if File.read(File.join('data', 'books.json')).empty?

    JSON.parse(File.read(File.join('data', 'books.json')))
  end

  def list_all_books
    return puts 'There are no books in the catalog' if @books.empty?

    puts 'Books are: '
    @books.each do |book|
      puts "Publisher: #{blue(book['publisher'])}, Cover state: #{blue(book['cover_state'])}, " \
           "Publish date: #{blue(book['publish_date'])}," \
           "Author: #{blue(@authors.get_author_full_name(book['author_id']))}, " \
           "Genre: #{blue(@genres.get_genre(book['genre_id']))}, " \
           "Label: #{blue(@labels.get_label(book['label_id']))}."
    end
  end

  def cover_state_handler(cover_state)
    return 'covered' if cover_state.downcase == 'y'

    'bad'
  end

  def add_book
    puts 'Please enter the following information'
    publisher = get_user_string('Publisher: ')
    cover_state = get_user_string('Cover state(y/n): ')
    cover_state = cover_state_handler(cover_state)
    publish_date = get_user_date('Publish date(yyyy-mm-dd): ')
    label = get_user_label('Choose Label: ', @labels)
    author = get_user_author('Choose author: ', @authors)
    genre = get_user_genre('Choose genre: ', @genres)
    label = Label.new(label['title'], label['color'], label['id'])
    author = Author.new(author['first_name'], author['last_name'], author['id'])
    genre = Genre.new(genre['name'], genre['id'])
    book = Book.new(publisher, cover_state, publish_date)
    book.label = label
    book.author = author
    book.genre = genre
    @books << book.to_hash
    write_books_to_file
    puts green('Book added successfully')
  end

  def write_books_to_file
    File.write(File.join('data', 'books.json'), JSON.pretty_generate(@books))
  end
end
