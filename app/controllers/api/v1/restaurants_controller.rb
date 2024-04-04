class Api::V1::RestaurantsController < ApplicationController
  def index
    if params[:name].present?
      @restaurants = Restaurant.where('name ILIKE ?', "%#{params[:name]}%")
    else
      @restaurants = Restaurant.all
    end
    render json: @restaurants.order(created_at: :desc)
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      render json: @restaurant, status: :created
    else
      render json: { error: @restaurant.errors.messages }, status: :unprocessable_entity
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update(restaurant_params)
      render json: @restaurant, status: :ok
    else
      render json: { error: @restaurant.errors.messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.destroy
      render json: { message: 'Restaurant successfully deleted.' }, status: :ok
    else
      render json: { error: 'Failed to delete the restaurant.' }, status: :unprocessable_entity
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :genre_id)
  end
end
