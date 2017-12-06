class UniversalPoint < ApplicationRecord

  LAST_YEAR = 2016
  THIS_YEAR = 2017

  class << self
    def accepted_probability comb, score, accepted_score, z_now, z_last
      score_last_year = get_score_last_year(comb, score)
      p score_last_year

      exponent = -(score_last_year - accepted_score) - 1 - (z_now - z_last) / 100.0
      prob = 1.0 / (1 + Math.exp(exponent))
      prob
    end

    def get_score_last_year comb, score
      point_now = self.point_in(THIS_YEAR, comb)
      point_last = self.point_in(LAST_YEAR, comb)

      percent_above_now = point_now.percent_above(score)
      point_last.score_with(percent_above_now)
    end

    def point_in year, comb
      find_by(year: year, combination: comb)
    end
  end

  def percent_above score
    total_student = ranges.sum
    total_less = ranges[0...score.truncate].sum

    return 1.0 * total_less / total_student
  end

  def score_with percent
    threshold = ranges.sum * percent
    sum_student = 0
    ranges.each.with_index do |number, index|
      sum_student += number
      if sum_student >= threshold
        return index + 1
      end
    end

    return 30
  end
end
