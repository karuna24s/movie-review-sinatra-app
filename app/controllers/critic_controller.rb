class CriticController < ApplicationController

  # SIGN UP
    get '/signup' do
      if is_logged_in?
        flash[:message] = "You were already logged in. Here are your reviews."
        redirect to '/reviews'
      else
        erb :'critic/create_critic'
      end
    end

    post '/signup' do
      if is_logged_in?
        flash[:message] = "You were already logged in. Here are your reviews."
        redirect to '/reviews'
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

    post "/login" do
      @critic = Critic.find_by(username: params[:username]) #find the user
      if @critic && @critic.authenticate(params[:password]) #check password matches
        session[:critic_id] = @critic.id   #log them in
        redirect "/reviews" #show them their reviews
      else
        flash[:message] = "Your username or password were not correct. Please try again."
        redirect "/login"
      end
    end

    # Log out
    get '/logout' do
      if is_logged_in?
        session.clear
        flash[:message] = "You have been logged out of your account."
        redirect '/login'
      else
        redirect '/'
      end
  end



end
