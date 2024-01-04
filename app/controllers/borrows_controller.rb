# app/controllers/borrows_controller.rb
class BorrowsController < ApplicationController
       
    def create
        @book = Book.find(params[:id])
        user_id = session[:user_id]
        @user = User.find_by(id: user_id)
      
        @borrow = Borrow.find_by(user_id: @user.id, book_id: @book.id)
      
        if @borrow
          @borrow_count = @borrow.borrow_count + 1
          @return_count = @borrow.returned_count
        else
          @borrow_count = 1
          @return_count = 0
        end
      
        @borrow = Borrow.new(
          user: @user,
          book: @book,
          borrow_date: Date.today,
          return_date: nil,
          returned_date: nil,
          borrow_count: @borrow_count,
          returned_count: @return_count,
          lost_book_count: 0,
          return_book: false
        )
      
        if @borrow.save

          @book.update(available_book_count: @book.available_book_count - 1)
      
          flash[:success] = "Book borrowed successfully. Borrow count: #{@borrow_count}"

          redirect_to borrowed_book_user_path
        else
          flash[:alert] = 'Error borrowing the book.'
          redirect_to books_path
        end
      end
      

      def return_book
        @book = Book.find(params[:id])
        user_id = session[:user_id]
        @user = User.find_by(id: user_id)
      
        @borrow = Borrow.find_by(user_id: @user.id, book_id: @book.id, return_book: false)
      
        if @borrow
          @borrow_count = @borrow.borrow_count - 1
          @return_count = (@borrow.returned_count || 0) + 1
      
          if @borrow.update(
            borrow_count: @borrow_count,
            returned_count: @return_count,
            return_date: Date.today + 10,
            returned_date: Date.today,
            return_book: true
          )
            @book.update(available_book_count: @book.available_book_count + 1)
      
            flash[:success] = "Book returned successfully. Return count: #{@return_count}"
            redirect_to root_path
          else
            flash[:error] = 'Error returning the book.'
            render :create
          end
        else
          flash[:error] = 'No active borrow found for returning the book.'
          redirect_to root_path
        end
      end

      
      def lose_book
        @book = Book.find(params[:id])
        user_id = session[:user_id]
        @user = User.find_by(id: user_id)
      
        @borrow = Borrow.find_by(user_id: @user.id, book_id: @book.id, return_book: false)
      
        if @borrow.present?
          @borrow_count = @borrow.borrow_count - 1
          @return_count = (@borrow.returned_count || 0) + 1
      
          if @borrow.update(
            borrow_count: @borrow_count,
            returned_count: @return_count,
            return_date: Date.today + 10,  
            returned_date: Date.today,
            return_book: true,
            lost_book_count: @borrow.lost_book_count + 1
          )
            @book.update(available_book_count: @book.available_book_count - 1)
      
            flash[:success] = "Book returned successfully. Return count: #{@return_count}"
            redirect_to root_path
          else
            flash[:error] = 'Error returning the book.'
            render :create
          end
        else
          flash[:error] = 'No active borrow found for returning the book.'
          redirect_to root_path
        end
      end
      
      
  end
  