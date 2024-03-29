class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @cur_path = "#{request.path}"
    @rats = ( @rats.nil? ? {} : "#{request.query_parameters['ratings']}")
    puts "query #{request.query_parameters}"
    puts "params #{params}"
    @title_header = "#{@cur_path}" == "/movies.title_header"
    @release_date_header = "#{@cur_path}" == "/movies.release_date_header"
#    @rats = (params[:ratings].nil? ? {} : params[:ratings])
    if !params[:ratings].nil?
      @movies = Movie.find_all_by_rating(params[:ratings].keys)
      @movies = ( @title_header ? Movie.order("title").find_all_by_rating(params[:ratings].keys) : @movies)
      @movies = ( @release_date_header ? Movie.order("release_date").find_all_by_rating(params[:ratings].keys) : @movies)
      @rats = (params[:ratings].nil? ? "#{request.query_parameters['ratings']}" : params[:ratings])
      @rats = params[:ratings]
    else
      @movies = Movie.all
      @movies = ( @title_header ? Movie.order("title") : @movies)
      @movies = ( @release_date_header ? Movie.order("release_date") : @movies)
    end
    puts @rats
    @all_ratings = Movie.all_ratings
  end
  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  def title_header
    @movie = movie.find(:all, :order => 'ASC')
  end
end
