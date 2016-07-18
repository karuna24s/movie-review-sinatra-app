class ReviewController < ApplicationController

  # Create
  get '/reviews/new' do # takes you to the create a movie review page
    if is_logged_in?
      erb :'reviews/new'
    else
      flash[:message] = "Looks like you weren't logged in yet. Please log in below."
      redirect to '/login'
    end
  end

  post '/reviews' do
    if params[:title] == "" || params[:genre] == "" || params[:content] == "" || params[:rating] == "" # must have title, genre, content, & rating
      flash[:message] = "Oops! Reviews must have a title, genre, content and rating. Please try again."
      redirect to '/reviews/new'
    else
      critic = current_critic
      @review = Review.create(
        :title => params[:title],
        :genre => params[:genre],
        :content => params[:content],
        :rating => params[:rating],
        :critic_id => critic.id)
      redirect to "/reviews/#{@review.id}"
    end
  end


  # Read
  get '/reviews' do
    if is_logged_in?
      @critic = current_critic
      @reviews = @critic.reviews.all
      erb :'reviews/index'
    else
      flash[:message] = "Looks like you weren't logged in yet. Please log in below."
      redirect to '/login'
    end
  end

  get '/reviews/:id' do
    if is_logged_in?
      @review = Review.find_by_id(params[:id])
      erb :'reviews/show'
    else
      flash[:message] = "Looks like you weren't logged in yet. Please log in below."
      redirect to '/login'
    end
  end

  # Update
  get '/reviews/:id/edit' do
    if is_logged_in?
      @review = Review.find_by_id(params[:id])
      if @review.critic_id == session[:critic_id]
        erb :'reviews/edit'
      else
        flash[:message] = "Sorry that's not your review. You can't edit it."
        redirect to '/reviews'
        end
    else
      flash[:message] = "Looks like you weren't logged in yet. Please log in below."
      redirect to '/login'
    end
  end




end
