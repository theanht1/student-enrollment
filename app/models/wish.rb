class Wish < ApplicationRecord
  belongs_to :user
  belongs_to :university

  def wish_response
    {
      id: id,
      combination: combination,
      university: university,
    }
  end
end
