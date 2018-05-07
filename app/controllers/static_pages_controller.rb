class StaticPagesController < ApplicationController
  def home
  	if params[:categoria]
  		# obtener todas las ideas de la categoría
  			#incluye tabla category_ideas     donde el category_id sea igual a los parameretros que seleccionan
  		@ideas = Idea.includes(:category_ideas).where("category_ideas.category_id" => params[:categoria])
    elsif params[:search] 
      #encontrar todas las ideas que concuerden con su title
      @ideas = Idea.where("title ILIKE ?", "%#{params[:search]}%")
  	else
  		# Enviar todas las ideas
	  	@ideas = Idea.all
  	end
  end
  def user_profile
    if params[:ideas]
      @usuario = User.includes(:ideas).where("user.id"=> params[:ideas])
    end
    
  end
end
