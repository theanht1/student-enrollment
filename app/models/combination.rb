class Combination < ApplicationRecord
  belongs_to :subject1, class_name: 'Subject', foreign_key: :id1
  belongs_to :subject2, class_name: 'Subject', foreign_key: :id2
  belongs_to :subject3, class_name: 'Subject', foreign_key: :id3
end
