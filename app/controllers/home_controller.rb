class HomeController < ApplicationController
  def index
  end

  def about
  end

  def pick_restaurant
    @restaurant = Restaurant.order("RANDOM()").first
    render json: @restaurant
  end
end
