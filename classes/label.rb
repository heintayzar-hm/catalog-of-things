class Label
  def initialize(title, color)
    @id = rand(1..1000)
    @title = title
    @color = color
    @items = []
  end

  def add_item(item)
    return 'Item is already in the label' if item.label == self
    return 'Pleas use item Class' if item.class != Item

    item.label = self
    items << item
  end
end
