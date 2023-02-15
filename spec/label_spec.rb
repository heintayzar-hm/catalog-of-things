require_relative 'helper_spec'

describe Label do
  before :each do
    @label = Label.new('JK Rowling', 'red', 1)
  end
  context 'given two arguments' do
    it 'is an object of Label ' do
      expect(@label).to be_an_instance_of(Label)
    end

    it 'has the given data ' do
      expect(@label).to have_attributes(title: 'JK Rowling', color: 'red')
    end

    it 'can have multiple items' do
      item1 = Item.new('2020-10-10', true)
      item2 = Item.new('2010-10-10', false)
      @label.add_item(item1)
      @label.add_item(item2)
      expect(@label.items.length).to eq(2)
    end
  end
end
