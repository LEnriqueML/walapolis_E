class User < ApplicationRecord
  # after_create :set_defaults
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
  		 :registerable,
         :recoverable, 
         :rememberable, 
         :trackable, 
         :validatable

  # private
  # 	def set_defaults
  # 		self.update(show_email: true, show_phone: false)
  # 	end

end
