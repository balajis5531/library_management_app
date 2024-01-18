class UsersController < ApplicationController
    before_action :set_user, only: [:show ,:edit, :update]

    def new
        @user= User.new
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
        @user = current_user
        @borrowed_books = @user.books
      end

    def borrowed_book  
        @user =  current_user
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

   private

    def user_params
        params.require(:user).permit(:username, :email , :password_digest, :mobile_number, :role)
    end

    def set_user
        @user = User.find(session[:user_id])
        rescue ActiveRecord::RecordNotFound
        flash[:alert] = "not found user"
    end
end
