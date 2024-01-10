
class BorrowsController < ApplicationController
         
  before_action :borrow_load, only: [:create, :return_book, :lose_book]

        def create
          @borrow = Borrow.new(
          user: current_user,
          book: @book,
          borrow_date: Date.today,
          return_date: Date.today + 10,
          returned_date: nil,
          return_book: false,
          lose_book: false
          
          )
          if @borrow.save
            flash[:success] = "Book borrowed successfully."
            redirect_to borrowed_book_user_path
          else
            flash[:alert] = 'Error borrowing the book.'
            redirect_to books_path
          end
        end
  
       

      def return_book
      
        @borrow = Borrow.find_by(user_id: current_user.id, book_id: @book.id)
          if @borrow.update(
            returned_date: Date.today,
            return_book: true
          )
            @book.update(available_book_count: @book.available_book_count + 1)   
            flash[:success] = "Book returned successfully."
            redirect_to root_path
          else
            flash[:alert] = 'Error returning the book.'
            render :create
          end
      end

      
      def lose_book
        @borrow = Borrow.find_by(user_id: current_user.id, book_id: @book.id)
          if @borrow.update(
            returned_date: Date.today,
            lose_book: true
          )
            flash[:success] = "Book returned successfully."
            redirect_to root_path
          else
            flash[:alert] = 'Error returning the book.'
            render :create
          end  
      end

      

      private

      def borrow_load
        @book = Book.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:alert] = 'Book not found.'     
        redirect_to books_path
      end

      
  end
  