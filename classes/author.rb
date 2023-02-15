class Author
  attr_accessor :id, :first_name, :last_name, :items

  def initialize(first_name, last_name, id)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @items = []
  end

  def add_item(item)
    @items << item
    item.author = self if item.author.nil?
  end
end
