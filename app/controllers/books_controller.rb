class BooksController < ApplicationController

before_action :authenticate_user!
  before_action :correct_user, only: [:update, :edit]

  def show
  	@book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
  end

  def index
  	@books = Book.all
    @book = Book.new #一覧表示するためにBookモデルの情報を全てくださいのall
  end

  def create
  	@book = Book.new(book_params)

    @book.user_id = current_user.id#Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
  	if @book.save
  		redirect_to book_path(@book.id), notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
    @books = Book.all
    @user = current_user#index.htmlで@userが定義されているので必要
  	render :index
  	end
  end

  def edit
  	@book = Book.find(params[:id])
  end



  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to @book, notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render "edit"
  	end
  end

  def delete
  	@book = Book.find(params[:id])
  	@book.destoy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body)
  end

   def correct_user
    book = Book.find(params[:id])
    if current_user.id != book.user.id
      redirect_to books_path
    end
  end

end
