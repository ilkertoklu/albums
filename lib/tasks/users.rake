namespace :users do
  desc "Import users from Source API"
  task import: :environment do
    require 'net/http'
    require 'json'

    url = 'https://jsonplaceholder.typicode.com/users'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    users = JSON.parse(response, symbolize_names: true)

    users.each do |user_data|
      User.create!(
        name: user_data[:name],
        username: user_data[:username],
        email: user_data[:email],
        phone: user_data[:phone],
        website: user_data[:website],
        address: {
          street: user_data[:address][:street],
          suite: user_data[:address][:suite],
          city: user_data[:address][:city],
          zipcode: user_data[:address][:zipcode],
          geo: user_data[:address][:geo]
        },
        company: {
          name: user_data[:company][:name],
          catchPhrase: user_data[:company][:catchPhrase],
          bs: user_data[:company][:bs]
        }
      )
    end

    puts "Users imported successfully!"
  end
end
