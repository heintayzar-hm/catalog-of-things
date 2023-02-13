require 'date'
class Item
  def initialize(publish_date, archive)
    @id = rand(1..1000)
    @genre = nil
    @author = nil
    @source = nil
    @label = nil
    @publish_date = Date.parse(publish_date)
    @archive = archive
  end

  def can_be_archived?
    Time.now.year - @publish_date.year > 10
  end

  def move_to_archive
    return unless can_be_archived?

    @archive = true
  end
end
