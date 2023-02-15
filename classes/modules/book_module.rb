require_relative '../book'
require_relative 'color'
require 'json'
class BookModule
  include ColorTerminal

  def initialize(labels, authors)
    @books = load_books
    @labels = labels
    @authors = authors
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
           "Publish date: #{blue(book['publish_date'])}, Label Title: #{blue(@labels.get_label(book['label_id']))}, " \
           "Authour Full Name: #{blue(@authors.get_author_full_name(book['author_id']))}"
    end
  end

  def get_user_string(msg)
    print cyan(msg)
    gets.chomp
  end

  def cover_state_handler(cover_state)
    return 'covered' if cover_state.downcase == 'y'

    'bad'
  end

  def valid_date?(date_string)
    Date.parse(date_string)
    true
  rescue ArgumentError
    false
  end

  def get_user_date(msg)
    date = get_user_string(msg)
    if valid_date?(date)
      date
    else
      puts red('Invalid date')
      get_user_date(msg)
    end
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

  def add_book
    puts 'Please enter the following information'
    publisher = get_user_string('Publisher: ')
    cover_state = get_user_string('Cover state(y/n): ')
    cover_state = cover_state_handler(cover_state)
    publish_date = get_user_date('Publish date(yyyy-mm-dd): ')
    label = get_user_label('Choose Label: ')
    author = get_user_author('Choose author: ')

    label = Label.new(label['title'], label['color'], label['id'])
    author = Author.new(author['first_name'], author['last_name'], author['id'])
    
    book = Book.new(publisher, cover_state, publish_date)
    book.label = label
    book.author = author
    @books << book.to_hash
    write_books_to_file
  end

  def write_books_to_file
    File.write(File.join('data', 'books.json'), JSON.pretty_generate(@books))
  end
end
