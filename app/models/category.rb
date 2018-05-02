class Category < ApplicationRecord
  has_many :category_ideas
  has_many :ideas, through: :category_ideas

   def to_param
  	"#{self.id}-#{self.name.parameterize}"
  end
end
