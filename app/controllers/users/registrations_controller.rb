class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  before_action :set_greeting, only: [:new]
  # GET /resource/sign_up
  # def new
  #   super
  # end

# aqui se crea la variable para cargar los elementos que necesitamos
  def profile
    #encontramos al usuario
    @user = User.find(params[:user_id])
    #encontramos las propuestas del usuario
    @ideas = Idea.where(user_id: @user.id)
    # Inicializamos likes
    @likes_global = 0
    @total_cost = 0
    # Validamos que existan ideas
    if @ideas.present?
      # Recorremos las propuestas del usuario y sumamos sus like y encontramos la mas popular
      # Sumamos totos sus likes
      # Encontramos su idea mas popular
      # Sumamos el costo total de sus ideas
      @most_popular = @ideas.first
      @ideas.each do |idea|
        if idea.likes.count > @most_popular.likes.count
          @most_popular = idea
        end 
        @total_cost += idea.initial_cost
        @likes_global += idea.likes.count
      end
    end
    if params[:filter]
        if params[:filter] == 'most_popular'
        @ideas = @ideas.sort_by{|idea| idea.total_like}.reverse
      elsif params[:filter] == 'most-recent'
        @ideas = @ideas.order('id desc')
      else
        @ideas = @ideas.order('id asc')
      end
    end
  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update
    # super
    new_params = params.require(:user).permit(:phone, :show_phone, :show_email, :bio, :current_password, :password, :password_confirmation, :full_name, :image)
    change_password = true
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
      new_params = params.require(:user).permit(:phone, :show_phone, :show_email, :bio, :full_name, :image)
      change_password = false
    end

    @user = User.find(current_user.id)
    is_valid = false

    if change_password
      is_valid = @user.update_with_password(new_params)
    else
      is_valid = @user.update_without_password(new_params)
    end

    if is_valid
      # set_flash_message :notice, :updated
      # sign_in @user, :bypass => true
      # redirect_to after_update_path_for(@user)
      redirect_to root_path, notice: 'Tu cuenta se ha actualizado'
    else
      render "edit"
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name, :phone, :image])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:phone, :show_phone, :show_email, :bio])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  # #  super(resource)
  #   edit_user_registration_path(resource)
  # end

  # def update_resource(resource, params)
  #   resource.update_without_password(params)    
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
