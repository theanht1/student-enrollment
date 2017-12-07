class Wish < ApplicationRecord
  belongs_to :user
  belongs_to :university

  def wish_response
    score = user.score_in(university.combination)
    {
      id: id,
      university: university,
      prob: university.accepted_probability(score),
      score: score
    }
  end

end
