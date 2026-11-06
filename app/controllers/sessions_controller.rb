class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    p user.inspect

    respond_to do |format|
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        format.html { redirect_to root_url, notice: "Welcome back.", status: :see_other} # what does "see other" does?
        format.json { head :no_content }
      else
        format.html { redirect_to root_url, status: :unprocessable_content, alert: "Something is wrong with your fields." }
        format.json { render json: @event.errors, status: :unprocessable_content }
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end
