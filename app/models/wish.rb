class Wish < ApplicationRecord
  belongs_to :user
  belongs_to :university

  def wish_response
    {
      id: id,
      university: university,
    }
  end
end
