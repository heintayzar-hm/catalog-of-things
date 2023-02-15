class Label
  def initialize(title, color, id)
    @id = id
    @title = title
    @color = color
    @items = []
  end
  attr_accessor :title, :color, :items
  attr_reader :id

  def add_item(item)
    return 'Item is already in the label' if item.label == self
    return 'Pleas use item Class' if item.class != Item

    item.label = self
    items << item
  end
end
