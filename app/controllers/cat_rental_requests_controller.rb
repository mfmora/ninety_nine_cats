class CatRentalRequestsController < ApplicationController
  def index
    # @cats = Cat.all
    # render :index
  end

  def show
    # @cat = Cat.find_by(id: params[:id])
    # if @cat
    #   render :show
    # else
    #   redirect_to cats_url
    # end
  end

  def new
    # @cat_rental_request = CatRentalRequest.new
    render :new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)
    if @cat_rental_request.save
      redirect_to cat_url(Cat.find_by(id: @cat_rental_request.cat_id))
    else
      render :new
    end
  end

  def edit
    # @cat = Cat.find_by(id: params[:id])
    # render :edit
  end

  def update
    # @cat = Cat.find_by(id: params[:id])
    #
    # if @cat.update_attributes(cat_params)
    #   redirect_to cat_url(@cat)
    # else
    #   render :edit
    # end
  end




  private
  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end
