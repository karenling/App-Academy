class SessionsController < ApplicationController
  # before_action :redirect_to_cats_index_if_current_user, only: [:new]

  def new

  end

  def create
      user = User.find_by_credentials(
      params[:login][:username],
      params[:login][:password]
      )

    if user
      #if the user exists, make a new Session
      session_model = Session.new(
        user_id: user.id,
        session_token: Session.create_session_token,
        media: request.env["HTTP_USER_AGENT"],
        location: (request.remote_ip).to_s
      )
      if session_model.save
      # logs this user in
        session[:session_token] = session_model.session_token
      end

      # user.reset_session_token!
      # login_user!(user)
      redirect_to cats_url
    else
      render :new
    end
  end

  def destroy
    Session.find_by(session_token: session[:session_token]).destroy
    # current_user.reset_session_token!
    session[:session_token] = nil

    redirect_to cats_url
  end

end
