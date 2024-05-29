class BooksController < ApplicationController
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
     redirect_to book_path(@book)
     flash[:notice] = "successfully"
    else
      @books = Book.all
      render :books
    end
  end
  
  def index
    @books = Book.all
    @book = Book.new

  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    
    if @book.update(book_params)
     redirect_to book_path(@book.id)
     flash[:notice] = "successfully"
    else
      
      render :edit
    end
    
  end
  
  # 削除機能
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end
  
  
   private

  def book_params
    params.require(:book).permit(:title, :body )
  end
end
