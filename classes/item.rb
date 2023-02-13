class Item
  def intialize(publish_date, archive)
    @id = rand(1..1000)
    @genre = nil
    @author = nil
    @source = nil
    @label = nil
    @publish_date = publish_date
    @archive = archive
  end

  def can_be_archived?
    return true if publish_date > 10

    false
  end

  def move_to_archive
    return unless can_be_archived?

    @archive = true
  end
end
