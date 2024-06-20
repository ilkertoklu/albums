# This file is used to seed the database with data from the placeholder API.

puts 'Seeding database from placeholder API...'

# Trigger rake task to seed db.
Rake::Task['users:import'].invoke
Rake::Task['albums:import'].invoke
Rake::Task['photos:import'].invoke

puts 'Database has been successfully seeded from placeholder API.'
