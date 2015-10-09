task import_users: :environment do
  UsersImporter.new(ENV['path']).call
end
