class BooksController < ApplicationController

  def index
    @books = Book.all
    @book = Book.new
  end

  # def new
  #   @book = Book.new
  # end

  def create
    @book = Book.new(book_params)
    if @book.save
      #サクセスメッセージ"
      redirect_to book_path(@book.id),flash: {s_create: "Book was successfully created."}
    else
      @books = Book.all
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    if @book.update(book_params)
      redirect_to book_path(@book.id), flash: {s_update:"Book was successfully updated."}
    else
      #↓ここに@bookを置くとBook.find(params[:id])から前の"空の"情報を持ってきてしまう
      #@book = Book.find(params[:id])
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    if book.destroy
      redirect_to books_path,flash:{s_destroy: "Book was successfully destroyed."}
    else

    end
  end

private
#paramsで取得したパラメーターに対し保存の許可処理を行うメソッド
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
