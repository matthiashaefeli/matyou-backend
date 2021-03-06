class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ create update destroy new edit index ]
  before_action :user_authenticated, only: %i[ create update destroy new edit index ]
  before_action :set_pages, only: %i[ index ]

  # GET /books or /books.json
  def index
    search_value = params[:search]
    @count = Book.all.count / 10
    @show_all = true if params[:show_all]
    @books = if params[:show_all]
               Book.order('created_at DESC')
             elsif
               search_value
               Book.where('lower(title) like ?', "%#{search_value.downcase}%")
             else
               Book.order('created_at DESC').limit(10).offset(@page * 10)
             end
  end

  # GET /books/1 or /books/1.json
  def show
    @comment = Comment.new
    @commenteable_type = 'Book'
    @commenteable_id = @book.id
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :body)
    end

    def set_pages
      @page ||= params[:page].to_i || 0
    end
end
