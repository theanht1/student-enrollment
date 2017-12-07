class User < ApplicationRecord
  has_secure_password

  has_many :wishes

  def detail_info
    self
    # self.as_json.merge({
    #   'scores' => scores_info
    # })
  end

  def scores_info
    scores.map do |score|
      subject = Subject.find(score['subject_id'])
      {
        subject: subject,
        score: score['score']
      }
    end
  end

  def score_in combination
    comb = Combination.find_by(code: combination)

    score1 = scores.find { |s| s['subject_id'] == comb.id1 } || {}
    score2 = scores.find { |s| s['subject_id'] == comb.id2 } || {}
    score3 = scores.find { |s| s['subject_id'] == comb.id3 } || {}

    priority_score + (score1['score'] || 0) + (score2['score'] || 0) + (score3['score'] || 0)
  end
end
