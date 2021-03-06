class SpendingsController < ApplicationController

  def index
    @user = current_user
    @spendings = @user.spendings.all
  end

  def everyone
    @user = User.where.not(id: current_user.id).all
  end

  def show
    @spending = Spending.find(params[:id])
  end

  def new
    @spending = Spending.new
    @genres = Genre.all
  end

  def create
    @spending = Spending.new(spending_params)
    @spending.user_id = current_user.id
    @spending.save!
    redirect_to spendings_path
  end

  def edit
    @spending = Spending.find(params[:id])
    @genres = Genre.all
  end

  def update
    @spending = Spending.find(params[:id])
    @spending.update(spending_params)
    redirect_to spendings_path
  end

  def destroy
    @spending = Spending.find(params[:id])
    @spending.destroy
    redirect_to spendings_path
  end

  private

  def spending_params
    params.require(:spending).permit(:spending_amount, :genre_id, :memo, :start_time)
  end
end
