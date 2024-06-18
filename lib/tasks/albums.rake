namespace :albums do
  desc 'Import albums from Source API'
  task import: :environment do
    require 'faraday'
    require 'json'

    response = Faraday.get('https://jsonplaceholder.typicode.com/albums')
    albums = JSON.parse(response.body, symbolize_names: true)

    albums.each do |album|
      user = User.find_by(id: album[:userId])
      if user
        user.albums.build(title: album[:title])
        user.save!
      else
        puts "User with id #{album[:userId]} not found"
      end
    end

    puts 'Albums have been successfully created from API data.'
  end
end
