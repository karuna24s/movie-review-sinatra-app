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
end
