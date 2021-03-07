class Challenge < ApplicationRecord
  has_rich_text :body
  has_many :comments, as: :commenteable
end
