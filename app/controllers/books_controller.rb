class BooksController < ApplicationController
    before_action :set_book, only: [:edit, :update, :destroy]
    
    def new
        @book = Book.new
    end 

    def admin_access
      @books = Book.all
    end

    def index
        @books = Book.all

        if params[:category].present?
          @books = @books.where(category: params[:category])
        end
    end
    

    def create
        @book = Book.new(book_params)
        if @book.save
            redirect_to books_path, notice: "book added success fuly"
        else
            render :new
        end
    end

    def edit
    end

    def show
        @book = Book.find(params[:id])
    end

    
    def update
        if @book.update(book_params)
            
          redirect_to books_path, notice: 'Book was successfully updated.'
        else
          render :edit
        end
      end
    
      def destroy

        @book.destroy

        redirect_to new_book_path, notice: 'Book was successfully deleted.'
      end

      def search

        @books = Book.all

        if params[:category].present?
          @books = @books.where(category: params[:category])
        end

        render json: @books
        
      end
      

    private

    def set_book
        @book = Book.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:alert] = 'Book not found.'
        redirect_to books_path
      end
    

    def book_params
       params.require(:book).permit(:name, :image_url, :author, :description, :year_of_release, :category, :available_book_count)
    end

    def valid
    end
end
