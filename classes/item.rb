require 'date'
class Item
  attr_accessor :id, :publish_date, :archive

  attr_reader :genre, :author, :source, :label

  def initialize(publish_date, archive)
    @id = rand(1..1000)
    @publish_date = Date.parse(publish_date)
    @archive = archive
  end

  def can_be_archived?
    Time.now.year - @publish_date.year > 10
  end

  def label=(label)
    @label = label
    label.add_item(self) unless label.items.include?(self)
  end

  def author=(author)
    @author = author
    author.add_item(self) unless author.items.include?(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_item(self) unless genre.items.include?(self)
  end

  def move_to_archive
    return unless can_be_archived?

    @archive = true
  end
end
