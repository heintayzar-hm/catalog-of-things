require 'time'
class Item
  attr_accessor :id, :publish_date, :archive

  attr_reader :genre, :source, :label, :author

  def initialize(publish_date, archive)
    @id = rand(1..1000)
    @publish_date = Time.parse(publish_date)
    @archive = archive
  end

  def can_be_archived?
    (Time.now - @publish_date) > 10.years
  end

  def label=(label)
    @label = label
    label.add_item(self) unless label.items.include?(self)
  end

  def author=(author)
    @author = author
    author.add_item(self) unless author.items.include?(self)
  end

  def move_to_archive
    return unless can_be_archived?

    @archive = true
  end
end
