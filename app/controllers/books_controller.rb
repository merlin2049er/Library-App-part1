class BooksController < ApplicationController
  include Pagy::Backend
  before_action :set_book, only: %i[ show edit update destroy borrow return]

  # GET /books or /books.json
  def index
    @books = Book.all

      @pagy, @books = pagy(@books)
  end

  # GET /books/1 or /books/1.json
  def show

    id = params[:id]
    @checkdoutby = Checkedout.where({ book_id: id, checkedoutstatus: true })
    @count = @checkdoutby.count

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
        format.html { redirect_to book_url(@book), notice: "Book was successfully created." }
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
        format.html { redirect_to book_url(@book), notice: "Book was successfully updated." }
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

  def borrow

  id = params[:id]

    # write to table checkedout
    c = Checkedout.new
    c.user_id = id
    c.book_id = @book.id
    c.checkedout = Date.today
    c.duedate = Date.today + 7
    c.checkedoutstatus = 'True'
    c.save

    flash.alert = @book.Title + " checked out..."
    redirect_to root_path

  end

  def checkedout

    @checkedout = Checkedout.where('user_id =?', current_user.id).and(Checkedout.where(checkedoutstatus: true))
    @count = @checkedout.count

  end

  def booklog

    @booklog = Checkedout.all
    @count = Checkedout.count

  end

  def return

    id = params[:id]

    returned = Checkedout.where(book_id: id).and(Checkedout.where(checkedoutstatus: true))
    returned.update(checkedoutstatus: false, returndate: Date.today)

    flash.alert =  "book returned..."
    redirect_to root_path

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:Title, :Author, :Genre, :Subgenre, :Pages, :Publisher, :Copies)
    end
end
