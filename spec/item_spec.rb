require_relative 'helper_spec'

describe Item do
  before :each do
    @item = Item.new('2020-10-10', true)
  end
  context 'given two arguments' do
    it 'is an object of Item ' do
      expect(@item).to be_an_instance_of(Item)
    end

    it 'has the given data ' do
      expect(@item).to have_attributes(publish_date: Date.parse('2020-10-10'), archive: true)
    end

    it 'can have one label' do
      @item.label = Label.new('JK Rowling', 'red', 1)
      expect(@item.label).to be_an_instance_of(Label)
    end

    it 'can be archived' do
      expect(@item.can_be_archived?).to eq(false)
    end
  end
end
