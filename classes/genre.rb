class Genre
  attr_accessor :id, :name, :items

  def intialize(name)
    @id = Random.rand(1..1000)
    @name = name
    @items = []
  end

  def add_item(item)
    @items << item
    item.genre = self if item.genre.nil?
  end
end
