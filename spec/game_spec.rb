require_relative 'spec_helper'

RSpec.describe Game do
  before :all do
    @game = Game.new(true, '2017-01-01', '2008-01-01')
  end

  describe '#checkout game content' do
    it 'has a multiplayer attribute' do
      expect(@game.multiplayer).to be true
    end
    it 'has a last_played attribute' do
      expect(@game.last_played).to eq Time.parse('2017-01-01')
    end
    it 'has a publish_date attribute' do
      expect(@game.publish_date).to be_a Date
    end
  end

  describe '#can_be_archived?' do
    it 'returns true if last_played_at is greater than 2 years ago' do
      expect(@game.can_be_archived?).to be true
    end

    it 'returns true if publish_date is greater than 10 years ago' do
      @game.publish_date = Time.parse('2005-01-01')
      expect(@game.can_be_archived?).to be true
    end

    it 'returns false if last_played_at is less than 2 years ago' do
      @game.last_played = Date.parse('2023-01-01')
      expect(@game.can_be_archived?).to be false
    end
  end
end
