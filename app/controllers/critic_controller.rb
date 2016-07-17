class CriticController < ApplicationController

  # SIGN UP
    get '/signup' do
      if is_logged_in?
        flash[:message] = "You were already logged in. Here are your patterns."
        redirect to '/reviews'
      else
        erb :'critic/create_critic'
      end
    end

    post '/signup' do
      if is_logged_in?
        flash[:message] = "You were already logged in. Here are your patterns."
        redirect to '/patterns'
      elsif params[:username] == "" || params[:password] == ""
        flash[:message] = "In order to sign up for account, you must have both a username & a password. Please try again."
        redirect to '/signup'
      else
        @critic = Critic.create(username: params[:username], password: params[:password])
        @critic.save
        session[:critic_id] = @critic.id #logged in. where is the sessions hash initially declared?
        redirect to '/reviews'
    end
  end




end
