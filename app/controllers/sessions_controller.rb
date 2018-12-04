class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password])
      log_in user
      flash[:success] = t ".success_message"
      redirect_to user
    else
      flash.now[:danger] = t ".error_messages"
      render :new
    end
  end

  def destroy
    log_out
    flash[:success] = t ".logout_messages"
    redirect_to root_path
  end
end
