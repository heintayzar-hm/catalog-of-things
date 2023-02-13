require_relative 'item'
class Book < Item
  attr_accessor :publisher, :cover_state, :publish_date

  def initialize(publisher, cover_state, publish_date, label = nil)
    super(publish_date, false)
    @publisher = publisher
    @cover_state = cover_state
    @label = label
  end

  def can_be_archived?
    @cover_state == 'not covered' || super
  end

  def to_hash(*_args)
    {
      'id' => @id,
      'publish_date' => @publish_date.strftime('%a %d %b %Y'),
      'publisher' => @publisher,
      'cover_state' => @cover_state,
      'label_id' => @label['id']
    }
  end
end
