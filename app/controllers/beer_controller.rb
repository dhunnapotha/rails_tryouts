class BeerController < ApplicationController
  def show
    @beer_type = params[:name]
  end


  private
end
