class MoviesController < ApplicationController
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end
  def index
    @movies = Movie.all_ratings
    @all_ratings = Movie.all_ratings
    if params[:ratings]
      @ratings_to_show = params[:ratings].keys
    else
      @ratings_to_show = []
    end
    
    @ratings_to_show.each do |rating|
      params[rating] = true
    end

    @movies = Movie.with_ratings(@ratings_to_show)
    if params[:sort]
      @movies = Movie.with_ratings(@ratings_to_show).order(params[:sort])
    else
      @movies = Movie.with_ratings(@ratings_to_show)
    end
  end

  def new
    # default: render 'new' template
  end
  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end
  def edit
    @movie = Movie.find params[:id]
  end
  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end
end