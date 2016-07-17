require './config/environment'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base

  # enable sessions
  configure do
    set :public_folder, 'public'
    set :views, '/app/views'
    enable :sessions
    set :session_secret, 'movies_are_awesome'
    register Sinatra::Flash
  end

  # Homepage
  get '/' do
    erb :index
  end

  def is_logged_in?
    !!session[:critic_id]
  end

  def current_user
    @critic = Critic.find(session[:critic_id])
  end
end
