namespace :users do
  desc 'Import users from Source API'
  task import: :environment do
    require 'faraday'
    require 'json'

    response = Faraday.get('https://jsonplaceholder.typicode.com/users')
    users = JSON.parse(response.body, symbolize_names: true)

    users.each do |user|
      User.create!(
        name: user[:name],
        username: user[:username],
        email: user[:email],
        phone: user[:phone],
        website: user[:website],
        address: {
          street: user[:address][:street],
          suite: user[:address][:suite],
          city: user[:address][:city],
          zipcode: user[:address][:zipcode],
          geo: user[:address][:geo]
        },
        company: {
          name: user[:company][:name],
          catchPhrase: user[:company][:catchPhrase],
          bs: user[:company][:bs]
        }
      )
    end

    puts 'Users have been successfully created from API data.'
  end
end
