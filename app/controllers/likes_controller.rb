class LikesController < ApplicationController
	# POST /likes/tgol/:user_id/:idea_id
	def the_god_of_likes
		user = User.find(params[:user_id])
		idea = Idea.find(params[:idea_id])
		# buscar si el usuario ya dio like a la idea
		if user.like_idea(idea)
			#borrar like
			like = Like.where("user_id = ? AND idea_id = ?", user.id, idea.id).take
			like.destroy
		else
			#crear like
			Like.create(user_id: user.id, idea_id: idea.id)
		end
	end
end
