require_relative 'helper_spec'

describe Genre do
  before :each do
    @genre = Genre.new(1, 'Gospel')
  end
  context 'given one argument' do
    it 'is an object of Genre ' do
      expect(@genre).to be_an_instance_of(Genre)
    end
    it 'can have one genre' do
      expect(@genre).to be_an_instance_of(Genre)
    end
    it 'has the given data ' do
      expect(@genre).to have_attributes(id: 'Gospel', items: [], name: 1)
    end
  end
end
