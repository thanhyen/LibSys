class BooksController < ApplicationController
	before_action :find_book, only: [:edit, :update]
	def index
		@books = Book.all
	end
	def show
		@book = Book.find(params[:id])
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
	private
	def find_book
		@book = Book.find(params[:id])
		# @book = Book.where(id: params[:id]).first
	end
	def book_params
		params.require(:book).permit(:ISBN, :title, :description, :authors, :status)
	end
end
