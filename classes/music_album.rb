require_relative 'item'

class MusicAlbum < Item
  attr_accessor :on_spotify

  def initialize(on_spotify, publish_date)
    super(publish_date, false)
    @on_spotify = on_spotify
    @items = []
  end

  def to_hash(*_args)
    {
      'id' => @id,
      'on_spotify' => @on_spotify,
      'publish_date' => @publish_date,
      'genre_id' => @genre.id,
      'label_id' => @label.id,
      'author_id' => @author.id
    }
  end

  private

  def can_be_archived?
    return true if super && @on_spotify

    false
  end
end
