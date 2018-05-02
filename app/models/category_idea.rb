class CategoryIdea < ApplicationRecord
  belongs_to :category
  belongs_to :idea
end
