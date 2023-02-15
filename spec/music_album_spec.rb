require_relative 'helper_spec'

describe MusicAlbum do
  before :each do
    @music_album = MusicAlbum.new(true, '2017-01-01')
    @music_album.genre = Genre.new(1, 'Gospel')
  end
  context 'given two arguments' do
    it 'is an object of MusicAlbum ' do
      expect(@music_album).to be_an_instance_of(MusicAlbum)
    end
    it 'has the given data ' do
      expect(@music_album).to have_attributes(on_spotify: true, publish_date: Date.parse('2017-01-01'))
    end
    it 'can have one genre' do
      expect(@music_album.genre).to be_an_instance_of(Genre)
    end
    it 'on_spotify should be true' do
      expect(@music_album.on_spotify).to be true
    end
  end
end
