class BeersController < ApplicationController
  before_action :set_beer, only: [:show, :edit, :update, :destroy, :take_one_down]

  respond_to :html

  def index
    if current_user
      if params[:search]
        @beers = Beer.search(params[:search])
        @beers = @beers.where("user_id = ?", current_user.id).order(:brewery, :name)
      else 
        @beers = Beer.where("user_id = ?", current_user.id).all.order(:brewery, :name)
      end
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
    redirect_to beers_path
  end
    
  def take_one_down
    if @beer.quantity > 0
        @beer.quantity -= 1
        @beer.save
        redirect_to beers_path
    else
        redirect_to beers_path, alert: "You're already out of this beer"
    end
  end

  def destroy
    @beer.destroy
    respond_with(@beer)
  end
    
  def import
    Beer.import(params[:file])
	redirect_to beers_path, notice: "Import submitted"
  end
    
  private
    def set_beer
      @beer = Beer.find(params[:id])
    end

    def beer_params
      params.require(:beer).permit(:user_id, :name, :brewery, :brewyear, :size, :quantity, :beertype)
    end
end
