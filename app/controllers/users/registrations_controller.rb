class Users::RegistrationsController < Devise::RegistrationsController
before_action :configure_sign_up_params, only: [:create]
before_action :configure_account_update_params, only: [:update]


  def index
    super
    # @user = User.all
  end

  def show
    @user = User.find(params[:id])
  end
  # GET /resource/sign_up
  def new
    # super
    if user_signed_in? && current_user.role == 'Admin'
      @user = User.new
      render 'new'
    end
    
  end

  # POST /resource
  def create
    # super # this calls Devise::Registrationsntrollers#create
    @user = User.new(configure_sign_up_params)
    if @user.save
      flash[:success] = "Welcome! You have signed up successfully!"
      redirect_to '/users'
    else
      render 'new'
      flash[:error] = @user.errors.messages
    end

  end

  # # GET /resource/edit
  def edit
    # super
    @user = User.where(id: params[:id]).first
    # @user = User.find(params[:id])
    # binding.pry
  end


  # # PUT /resource
  def update
    # super
    @user.update(user_params)
    if @user.save
      flash[:success] = "update user successfully!"
      # redirect_to '/users_list'
      redirect_to '/users'
    else
      render 'edit'
      flash[:error] = @user.errors.message
    end
  end

  # # DELETE /resource
  def destroy
    # super
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to '/users'
      flash[:success] = "User is destroyed successfully!"
    end
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # # removing all OAuth session data.
  # def cancel_edit
  #   # super
  #   redirect_to '/users'
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    # devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
    # devise_parameter_sanitizer.permit(:sign_up) do |user_params|
    #   user_params.permit(:email, :password, :password_confirmation)
    # end
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def find_user
    @user= User.where(id: params[:id]).first
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :role)
  end

  def is_admin

    if current_user.role == 'Admin'
       # binding.pry
      return true
    else
      return false
    end
  end
end
