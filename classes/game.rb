require 'active_support/all'
require_relative 'item'

class Game < Item
  attr_accessor :multiplayer, :last_played

  def initialize(multiplayer, last_played, publish_date = Time.now)
    super(publish_date, false)
    @multiplayer = multiplayer
    @last_played = Time.parse(last_played)
  end

  def can_be_archived?
    @last_played < 2.years.ago && super
  end

  def to_hash(*_args)
    {
      'id' => @id,
      'publish_date' => @publish_date.strftime('%a %d %b %Y'),
      'multiplayer' => @multiplayer,
      'last_played' => @last_played.strftime('%a %d %b %Y'),
      'author' => @author,
      'label' => @label
    }
  end

end
