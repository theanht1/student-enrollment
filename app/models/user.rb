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
end
