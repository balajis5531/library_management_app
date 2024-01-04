class UsersController < ApplicationController
    before_action :set_user, only: [:show ,:edit, :update, :destroy]

    def new
        @user= User.new
    end
    def index
        @borrows = Borrow.where(user_id: session[:user_id])
    end

    
    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to login_path, notice: "success full rigister"
        else
            render :new
        end
    end

    def edit
    end

      def show

        @user = User.find(session[:user_id])
        @borrowed_books = @user.books
        @find = Borrow.where(user_id: session[:user_id])
        @lost_book= 0;
        @find.each do |book|
          @lost_book += book.lost_book_count
        end  
      end
    def borrowed_book
        
        user_id = session[:user_id]

        @user = User.find_by(id: user_id)
        
        @borrowed_books = @user.books

    end

    def update
        
        if @user.update(user_params)

            redirect_to root_path , notice: "success full update"
        else
            flash[:alert] = "update fail"
            render :new
        end
    end

    def destroy
        
    end

   private

    def user_params
        params.require(:user).permit(:username, :email , :password_digest, :mobile_number)
    end

    def set_user

        @user = User.find(session[:user_id])
        rescue ActiveRecord::RecordNotFound
        flash[:alert] = "not found user"
        
    end
end
