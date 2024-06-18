require 'faraday'
require 'json'

namespace :photos do
  desc 'Import photos from Source API'
  task import: :environment do
    response = Faraday.get('https://jsonplaceholder.typicode.com/photos')
    photos = JSON.parse(response.body, symbolize_names: true)

    photos.each do |photo|
      album = Album.find_by(id: photo[:albumId])
      if album
        album.photos.build(
          title: photo[:title],
          url: photo[:url],
          thumbnail_url: photo[:thumbnailUrl]
        )
        album.save!
      else
        puts "Album with id #{photo[:albumId]} not found"
      end
    end

    puts 'Photos have been successfully created from API data.'
  end
end
