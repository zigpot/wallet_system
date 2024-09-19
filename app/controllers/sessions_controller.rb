class SessionsController < ApplicationController
    def new
      # This will render the login form (view should be created)
    end
  
    def create
      user = User.find_by(email: params[:email])
  
      if user&.authenticate(params[:password])
        session[:user_id] = user.id  # Store user id in session to keep the user logged in
        redirect_to root_path, notice: 'Signed in successfully.'
      else
        flash.now[:alert] = 'Invalid email or password.'
        render :new
      end
    end
  
    def destroy
      session[:user_id] = nil  # Clear the session (log out the user)
      redirect_to root_path, notice: 'Signed out successfully.'
    end
  end