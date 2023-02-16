class Genre
  attr_accessor :id, :name, :items

  def initialize(name, id)
    @id = id
    @name = name
    @items = []
  end

  def add_item(item)
    @items << item
    item.genre = self if item.genre.nil?
  end
end
