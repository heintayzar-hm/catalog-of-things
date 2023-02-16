require_relative 'item'
class Book < Item
  attr_accessor :publisher, :cover_state, :publish_date

  def initialize(publisher, cover_state, publish_date)
    super(publish_date, false)
    @publisher = publisher
    @cover_state = cover_state
  end

  def can_be_archived?
    @cover_state == 'bad' || super
  end

  def to_hash(*_args)
    {
      'id' => @id,
      'publish_date' => @publish_date.strftime('%a %d %b %Y'),
      'publisher' => @publisher,
      'cover_state' => @cover_state,
      'genre_id' => @genre.id,
      'label_id' => @label.id,
      'author_id' => @author.id
    }
  end
end
