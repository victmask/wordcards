class CardsController < ApplicationController

  respond_to :html

  before_filter ->{@card = Card.find_by_uuid(params[:id])}, only: [:edit, :update, :show, :destroy]


  def index
    @my_twitter = session[:my_twitter] || '@mytwitter'
    @cards = Card.all.paginate(:page => params[:page])
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(params[:card])
    result = @card.save
    result || (render(action: :new) && return)
    redirect_to :root
  end

  def show
  end

  def edit
  end

  def update
    result = @card.update_attributes(params[:card])
    result || (render(action: :edit) && return)
    redirect_to @card, notice: "Word card was successfully updated"
  end

  def destroy
    @card.destroy
    redirect_to cards_path
  end
end
