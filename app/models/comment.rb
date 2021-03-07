class Comment < ApplicationRecord
  has_rich_text :body
  belongs_to :commenteable, polymorphic: true
end
