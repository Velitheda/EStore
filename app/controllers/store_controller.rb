class StoreController < ApplicationController
  skip_before_action :authorize
  include CurrentCart
  before_action :set_cart
  def index
  	@products = Product.order(:title)
  	@num_visits = num_visits

  end

  def num_visits
  	if session[:counter].nil?
  		session[:counter] = 1
  	else
  		session[:counter] += 1
  	end

  end
end
