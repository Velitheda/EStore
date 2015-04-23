class StoreController < ApplicationController


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
