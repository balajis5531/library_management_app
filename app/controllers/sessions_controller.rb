class SessionsController < ApplicationController

  def new
  end

  def create

      @user = User.find_by(email: params[:email])
    
      if @user && @user.password_digest == (params[:password])

      reset_session
      log_in @user
      redirect_to user_path(id: current_user)

      else

        flash.now[:alert] = 'Invalid email or password.'

        redirect_to login_path

      end

  end    

  def destroy

    log_out
    redirect_to root_path, notice: 'Logged out successfully.'
  end

 

end
