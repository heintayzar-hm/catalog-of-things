require_relative 'helper_spec'

describe MusicAlbum do
  before :each do
    @music_album = MusicAlbum.new('2017-01-01', 'Gospel', true)
  end
  context 'Should have the properties for Music Album' do
    it 'on_spotify should be true' do
        expect(@music_album.on_spotify).to be true
      end
    it 'publish_date should be 2017-01-01' do
      expect(@music_album.publish_date).to eq Time.parse('2017-01-01')
    end
    it 'genre should be Gospel' do
      expect(@music_album.genre).to be('Gospel')
    end
  end
end
