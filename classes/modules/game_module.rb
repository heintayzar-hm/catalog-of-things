require 'classes/item'

class Game < Item
    attr_accessor :multiplayer, :last_played
    def initialize(multiplayer, last_played)
        multiplayer = multiplayer
        last_played_at = last_played
    end

    def can_be_archived?
        return true if last_played > 10 && last_played_at < 2

        false
    end

end