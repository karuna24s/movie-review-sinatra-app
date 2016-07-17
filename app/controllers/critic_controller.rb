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

    # LOG IN
    get '/login' do #renders the log in page
      if is_logged_in?
        flash[:message] = "You were already logged in."
        redirect '/reviews'
      else
        erb :'critic/login'
      end
    end

    post '/login' do
      @critic = Critic.find_by(username: params[:username]) # find the critic
      if @critic && @critic.authenticate(params[:password]) # checks if the password matches
        session[:critic_id] = @critic_id # log them in
        redirect "/reviews" 
      else
        flash[:message] = "Your username or password were not correct. Please try again."
        redirect "/login"
      end
    end





end
