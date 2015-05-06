class BeersController < ApplicationController
  before_action :set_beer, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    if current_user
      @beers = Beer.where("user_id = ?", current_user.id).all.order(:brewery, :name)
      respond_with(@beers)
    end
  end
    
  def deleteindex
      @beers = Beer.where("user_id = ?", current_user.id).all.order(:brewery, :name)
      @beers = @beers.contains(params[:contains]) if params[:contains].present?
      respond_with(@beers)
  end

  def show
    respond_with(@beer)
  end

  def new
    @beer = Beer.new
    respond_with(@beer)
  end

  def edit
  end

  def create
    @beer = Beer.new(beer_params)
    @beer.user_id = current_user.id
    @beer.save
    redirect_to beers_path
  end

  def update
    @beer.update(beer_params)
    respond_with(@beer)
  end

  def destroy
    @beer.destroy
    respond_with(@beer)
  end

  private
    def set_beer
      @beer = Beer.find(params[:id])
    end

    def beer_params
      params.require(:beer).permit(:user_id, :name, :brewery, :brewyear, :size, :quantity)
    end
end
