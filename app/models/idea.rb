class Idea < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :category_ideas
  has_many :categories, through: :category_ideas
  has_many :comments

  def show_categories
  	categories = self.categories
  	text = ""
  	categories.each do |category|
  		text += "#{category.name} "
  	end
  	return text
  end
  
  def to_param
    # crea una ruta "personalizada" para el link
  	# "#{self.id}-#{self.title.parameterize}"
    # Se cambia la linea anterior con un try para evitar un error si aun no existe la idea
    "#{self.id}-#{self.title.try(:parameterize)}"
  end

  def total_like
    likes = Like.where(idea_id: self.id).count 
    return likes
  end
  
  def total_comments
    comments = Comment.where(idea_id: self.id).count 
    return comments
  end


  # def url
  #   url = "#{request.protocol}#{request.host_with_port}#{request.fullpath}"
  #   return url
    
  # end


end
