require_relative 'spec_helper'

RSpec.describe Author do
  describe '#initialize' do
    it 'creates an Author with a unique id, first name, and last name' do
      author1 = Author.new('John', 'Doe', 1)
      author2 = Author.new('Jane', 'Doe', 2)
      expect(author1.id).to_not eq(author2.id)
      expect(author1.first_name).to eq('John')
      expect(author1.last_name).to eq('Doe')
    end
  end

  describe '#add_item' do
    before :all do
      @author = Author.new('John', 'Doe', 1)
      @game = Game.new(true, '2017-01-01', '2008-01-01')
    end

    it 'adds an item to the items array' do
      expect { @author.add_item(@game) }.to change { @author.items.length }.by(1)
      expect(@author.items[0]).to eq @game
    end
  end
end
