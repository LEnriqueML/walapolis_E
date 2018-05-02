class StaticPagesController < ApplicationController
  def home
  	if params[:categoria]
  		# obtener todas las ideas de la categoría
  			#incluye tabla category_ideas     donde el category_id sea igual a los parameretros que seleccionan
  		@ideas = Idea.includes(:category_ideas).where("category_ideas.category_id" => params[:categoria])
  	else
  		# Enviar todas las ideas
	  	@ideas = Idea.all
  	end
  end
end
