require_relative 'app'
require 'fileutils'

def main()
  app = App.new
  app.run
end

def file_load
  folder = 'data'
  files = ['books.json', 'labels.json', 'authors.json', 'games.json',
           'genres.json', 'music_album.json'] # add file names here
  FileUtils.mkdir_p(folder)

  files.each do |file|
    path = File.join(folder, file)
    File.new(path, 'w') unless File.exist?(path)
  end
end
file_load
main
