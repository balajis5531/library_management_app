class SessionsController < ApplicationController

  def new
  end

  def create

      @user = User.find_by(email: params[:email])
    
      if @user && @user.password_digest == (params[:password])
        session[:user_id] = @user.id
        redirect_to root_path, notice: 'Logged in successfully.'
      else
        flash.now[:alert] = 'Invalid email or password.'
        redirect_to login_path
      end
  end    

  def destroy
    log_out
    redirect_to root_path, notice: 'Logged out successfully.'
  end

  private

  def log_out

    session.delete(:user_id)
  end

end
