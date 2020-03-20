class Api::V1::MoviesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    if params[:query].present?
      movies = Movie.where("release = ? OR title = ? OR overview = ? OR vote = ?", params[:query], params[:query], params[:query], params[:query])
    elsif params[:start].present?
      start_date = params[:start]
      end_date = params[:end]
      range = (start_date..end_date)
      movies = Movie.where(release: range)
    else
      movies = Movie.all
    end
     render json: movies, status: 201
  end

  def search
    name = params[:name]
    error = 'No hay resultados'
    request = HTTParty.get("https://api.themoviedb.org/3/search/movie?api_key=a85085d5944badafb9e37c79d101e3e7&query=#{name}")
    result = JSON.parse request.to_s
    propiedades = {
      :id => result['results'][0]['id'],
      :title => result['results'][0]['title'],
      :overview => result['results'][0]['overview'],
      :vote => result['results'][0]['vote_count'],
      :poster => result['results'][0]['poster_path'],
      :release => result['results'][0]['release_date']}

      if result['status_code'] === 34
        render json: error
      else
        render json: propiedades, status: 201
      end
    end

    def create
      request = Movie.create(movies_params)

      if request.save
        render json: request, status: 201
      else
        render json: { errors: request.errors }, status: 422
      end
    end

    def destroy
      movie = Movie.find(params[:id])
      movie.destroy

      head 204
    end

    private
    def movies_params
      params.require(:movie).permit(:id_movie, :title, :overview, :vote, :poster, :release)
    end
  end
