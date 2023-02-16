require 'json'
require_relative 'color'

class AuthorModule
  include ColorTerminal
  def initialize
    @authors = load_authors
  end
  attr_accessor :authors

  def load_authors
    return [] if File.read(File.join('data', 'authors.json')).empty?

    JSON.parse(File.read(File.join('data', 'authors.json')))
  end

  def list_all_authors
    return puts red('There are no authors in the catalog') if @authors.empty?

    @authors.each_with_index do |author, index|
      puts "#{blue((index + 1).to_s)}) Full Name: #{blue("#{author['first_name']} #{author['last_name']}")}, " \
    end
  end

  def get_author_full_name(id)
    selected_author = @authors.find { |author| author['id'] == id }
    "#{selected_author['first_name']} #{selected_author['last_name']}"
  end
end
