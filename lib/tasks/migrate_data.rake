require 'csv'

desc "Add users"
task add_users: :environment do
  users = CSV.read('./lib/tasks/seeds_db/user.csv')

  users[1..-1].each do |user|
    u = User.new({
      sbd: user[3],
      name: user[1],
      birthday: user[2],
      password: user[3],
      password_confirmation: user[3]
    })

    u.save
  end
end
