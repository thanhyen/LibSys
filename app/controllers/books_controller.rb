class BooksController < ApplicationController
	before_action :find_book, only: [:edit, :update, :show, :borrow_return, :checkout_history]
	def index
		@books = Book.all
	end
	def show
		@book = Book.find(params[:id])
		# @history = History.check_his_book(@book.id)
	end

	# history
	def history
		@book = Book.find(params[:id])
		@history = History.check_his_book(@book.id)
	end

	def new
		@book = Book.new
	end

	def create
		@book = Book.new(book_params)
		if @book.save
			flash[:success] = "create book successfully!"
			redirect_to '/books'
		else
			render 'new'
			flash[:error] = @book.errors.message
		end
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		if @book.update(book_params)
			flash[:success] = "update book successfully!"
			redirect_to '/books'
		else
			render 'edit'
			flash.alert = "Failed Updating book! "
			flash[:error] = @book.errors.message
		end
	end

	def cancel
		redirect_to '/books'
		flash[:msg] = ""
	end
	def destroy
		@book = Book.find(params[:id])
		if @book.destroy
			flash[:success] = "DELELTE book successfully!"
			redirect_to '/books'
		else
			flash[:error] = @book.errors.message
		end
	end

	# search
 
	def search
	  @books = Book.all
	  if params[:search]
	    @books = Book.search(params[:search]).order("created_at DESC")
	    # binding.pry
	  else
	    @books = Book.all.order('created_at DESC')
	  end
	end

	# borrow-return
	def borrow_return
			 
			@history = History.new
			# @history.update(:book_id => @book.id, :user_id => current_user.id,:checkout_date => '', :return_date => '')
			@history.book_id = @book.id
			@history.user_id = current_user.id
			@history.checkout_date = ''
			@history.return_date = ''
			
		if @book.status == 'available'
			@history.action = 'Borrow'
			@book.update({:status => "checkout"});
			@book.update({:user => current_user});

			@history.checkout_date = Time.current()
			# @history.update({:checkout_date => Time.current()})
			
		else
			if @book.status == 'checkout' 
				@history.action = 'Return'
				@book.update({:status => "available"});
				@book.update({:user => nil});

				@history.return_date = Time.current()
				# @history.update({:return_date => Time.current()})
			end
		end
		if @history.save
			flash.alert = @history.action + " book successfully!"
		    render 'borrow_return'
		end

		# binding.pry
		# if @book.update(book_params)
		# # if @book.save(book_params)
		# 	flash.alert = "Updating book successfully! "
		# else
		# 	flash.alert = "Failed Updating book! "
		# end
	end

	private
	def find_book
		@book = Book.find(params[:id])
		# @book = Book.where(id: params[:id]).first
	end
	def book_params
		params.require(:book).permit(:ISBN, :title, :description, :authors, :status, :image, :user)
	end
	def history_params
		params.require(:history).permit(:book_id, :user_id, :checkout_date, :return_date)
	end
end
