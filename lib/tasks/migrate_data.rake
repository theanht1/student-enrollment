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

desc "Initial subjects"
task init_subjects: :environment do
  subjects = CSV.read('./lib/tasks/seeds_db/subject.csv')

  subjects[1..-1].each do |subject|
    Subject.create({
      id: subject[0],
      name: subject[1]
    })
  end
end

desc "Initial combinations"
task init_combinations: :environment do
  combinations = CSV.read('./lib/tasks/seeds_db/combination.csv')

  combinations[1..-1].each do |comb|
    Combination.create({
      id: comb[0],
      code: comb[1],
      id1: comb[2],
      id2: comb[3],
      id3: comb[4]
    })
  end
end

desc "Initial universal points"
task init_universal_points: :environment do
  points = CSV.read('./lib/tasks/seeds_db/universal_point.csv')

  points[1..-1].each do |point|
    UniversalPoint.create({
      id: point[0],
      year: point[1],
      combination: point[2],
      ranges: point[3..-1],
    })
  end
end

desc "Initial universities"
task init_universities: :environment do
  unis = CSV.read('./lib/tasks/seeds_db/universities.csv')

  unis[1..-1].each do |uni|
    combs = uni[3].split(',').map { |comb| comb.strip }
    University.create({
      code: uni[0],
      name: uni[1],
      branch: uni[2],
      combinations: combs,
      amount_2016: uni[4],
      score_2016: uni[5],
      amount_2017: uni[6]
    })
  end
end

desc "Add university rank"
task add_university_rank: :environment do
  unis = CSV.read('./lib/tasks/seeds_db/university_rank.csv')

  unis[1..-1].each do |ur|
    University.where(code: ur[0]).all.each do |uni|
      uni.update(rank: ur[2])
    end
  end
end

desc "Add university threshold score"
task add_threshold_score: :environment do
  University.all.each do |uni|
    if uni.combinations.include?('B00')
      uni.update(threshold_score: 17 + rand(3))
    else
      uni.update(threshold_score: 14 + rand(3))
    end
  end
end
