require_relative 'helper_module'

class GenreModule
  include ColorTerminal
  def initialize
    @genres = load_genre
  end
  attr_accessor :genres

  def load_genre
    return [] if File.read(File.join('data', 'genres.json')).empty?

    JSON.parse(File.read(File.join('data', 'genres.json')))
  end

  def list_all_genres
    return puts red('There are no labels in the catalog') if @genres.empty?

    @genres.each_with_index do |genre, index|
      puts "#{blue((index + 1).to_s)}) Name: #{blue(genre['name'])}"
    end
  end

  def get_genre(id)
    @genres.find { |genre| genre['id'] == id }['name']
  end
end
