require_relative 'helper_spec'

describe Book do
  before :each do
    @book = Book.new('John', 'bad', '2020-10-10')
  end
  context 'given three arguments' do
    it 'is an object of Book ' do
      expect(@book).to be_an_instance_of(Book)
    end

    it 'has the given data ' do
      expect(@book).to have_attributes(publisher: 'John', cover_state: 'bad', publish_date: Date.parse('2020-10-10'))
    end

    it 'can be archived' do
      expect(@book.can_be_archived?).to eq(true)
    end
  end
end
