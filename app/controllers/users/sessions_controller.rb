class Users::SessionsController < Devise::SessionsController
before_action :configure_sign_in_params, only: [:create]
before_filter :find_user, only: [:destroy, :edit]

  # GET /resource/sign_in
  def new
    super
  end

  # # POST /resource/sign_in
  def create
    super
    # @user = Users.new(configure_sign_in_params)
    # if @user.save
    #   rediret_to '/'
    # else
    #   render 'new'
    #   flash[:error] =@user.errors.message
    # end
  end

  # edit
  def edit
    
  end

  # # DELETE /resource/sign_out
  def destroy
    super
    # if @user.destroy
    #   rediret_to '/'
    #   flash[:success] = 'User is destroyed successfully!'
    # end
  end

  protected

  # # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    # devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
      user_params.permit(:email, :password)
    end
  end
  def find_user
    @user= User.where(id: params[:id]).first
  end
end
