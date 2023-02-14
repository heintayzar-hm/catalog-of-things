require_relative 'item'

class Game < Item
  attr_accessor :multiplayer, :last_played

  def initialize(multiplayer, last_played, publish_date, archive)
    super(publish_date, archive)
    @multiplayer = multiplayer
    @last_played_at = last_played
  end

  def can_be_archived?
    @last_played_at > 2 && super
  end
end
