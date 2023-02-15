require_relative 'helper_spec'

describe MusicAlbum do
  music_album = MusicAlbum.new(true, '2019-1-11')
  genre = Genre.new('Gospel')
  music_album.add_genre(genre)

  it 'should be an instance of MusicAlbum' do
    expect(music_album).to be_an_instance_of(MusicAlbum)
  end

  it 'archived should be false' do
    expect(music_album.archive).to be false
  end

  it 'on_spotify should be true' do
    expect(music_album.on_spotify).to be true
  end

  it 'genre property should be an instance of Genre' do
    expect(music_album.genre).to be_an_instance_of(Genre)
  end

  it 'genre should be Gospel' do
    expect(music_album.genre).to eq('Gospel')
  end
end
