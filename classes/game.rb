require_relative 'item'
require 'active_support/all'

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
end
