class UserManagementController < ApplicationController
	before_action :find_user, only: [:edit, :update, :destroy, :show, :checkout_history]
	def index
		@users = User.all
		# @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
	end

	def show
		@user = User.find(params[:id])
	end

	def new
		if user_signed_in? && current_user.role == 'Admin'
	      @user = User.new
	      render 'new'
    	end
		# @user = User.new
	end

	def create
		@user = User.new
		if @user.save
			flash[:success] = "create user successfully!"
			redirect_to '/users'
		else
			render 'new'
			flash[:error] = @user.errors.messages
		end
	end

	def edit
	end

	def update
		
		@user.update(user_params)
		if @user.save
			flash[:success] = "update user successfully!"
			# redirect_to '/users_list'
			redirect_to '/users'
		else
			render 'edit'
			flash[:error] = @user.errors.messages
		end
	end

	def cancel_edit
		redirect_to '/users'
	end

	def destroy
		if @user.id != current_user.id
		  if @user.destroy
			flash[:success] = "DELELTE user successfully!"
			redirect_to '/users'
		  else
			flash[:error] = @user.errors.messages
		  end
		else
			flash.alert = "You can't Delete yourself!"
		end
		
	end

	# search
 
	def search
	  @users = User.all
	  if params[:search]
	    @users = User.search(params[:search]).order("created_at DESC")
	    # binding.pry
	  else
	    @users = User.all.order('created_at DESC')
	  end
	end

	# checkout history
	def checkout_history
		@histories = History.check_his_user(@user.id)
	end

	private
	def find_user
		@user = User.where(id: params[:id]).first
	end
	def user_params
		params.require(:user).permit(:username, :email,:role, :password, :password_confirmation, :current_password)
	end

	def is_admin
		if current_user.role == 'Admin'
			return true
		else
			return false
		end
	end
end

