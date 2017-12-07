class University < ApplicationRecord

  def accepted_probability score
    if score < threshold_score
      return 0
    end

    UniversalPoint.accepted_probability(combination, score, score_2016,
      amount_2017, amount_2016)
  end
end
