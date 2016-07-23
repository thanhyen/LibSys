class UserManagementController < ApplicationController
	before_action :find_user, only: [:edit, :update, :destroy, :show]
	def index
		@users = User.all
	end

	# def show
	# 	@user = User.find(params[:id])
	# end

	def new
		@user = User.new
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
		
		if @user.update(user_params)
			flash[:success] = "update user successfully!"
			# redirect_to '/users_list'
			redirect_to '/users'
		else
			# puts "error update"
			render 'edit'
			flash[:error] = @user.errors.messages
		end
	end
	def cancel_edit
		redirect_to '/users'
	end

	def destroy

		if @user.destroy
			flash[:success] = "DELELTE user successfully!"
			redirect_to '/users'
		else
			flash[:error] = @user.errors.messages
		end
	end
	private
	def find_user
		@user = User.where(id: params[:id]).first
	end
	def user_params
		params.require(:user).permit(:username, :email,:role, :password, :password_confirmation, :current_password)
	end

	def is_admin
		if current_user.role == 'admin'
			return true
		else
			return false
		end
	end
end

