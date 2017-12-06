class Wish < ApplicationRecord
  belongs_to :user
  belongs_to :university

  def wish_response
    score = user_score
    {
      id: id,
      combination: combination,
      university: university,
      prob: accepted_probability(score),
      score: score
    }
  end

  def user_score
    comb = Combination.find_by(code: combination)

    scores = user.scores

    score1 = scores.find { |s| s['subject_id'] == comb.id1 } || {}
    score2 = scores.find { |s| s['subject_id'] == comb.id2 } || {}
    score3 = scores.find { |s| s['subject_id'] == comb.id3 } || {}

    score = (score1['score'] || 0) + (score2['score'] || 0) + (score3['score'] || 0)
  end

  def accepted_probability score
    if score < university.threshold_score
      return 0
    end

    UniversalPoint.accepted_probability(combination, score, university.score_2016,
      university.amount_2017, university.amount_2016)
  end
end
