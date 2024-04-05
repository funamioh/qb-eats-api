class Api::V1::GenresController < ApplicationController
  def index
    if params[:name].present?
      @genres = Genre.where('name ILIKE ?', "%#{params[:name]}%")
    # elsif params[:id].present?
    #   @genres = Genre.find(id: params[:id])
    else
      @genres = Genre.all
    end
    render json: @genres.order(created_at: :desc)
  end

  def show
    @genre = Genre.find(params[:id])
    render json: @genre
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      render json: @genre, status: :created
    else
      render json: { error: @genre.errors.messages }, status: :unprocessable_entity
    end
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      render json: @genre, status: :ok
    else
      render json: { error: @genre.errors.messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    if @genre.destroy
      render json: { message: 'Genre successfully deleted.' }, status: :ok
    else
      render json: { error: 'Failed to delete the genre.' }, status: :unprocessable_entity
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
