class SpendingsController < ApplicationController

  def index
    @user = current_user
    @spendings = @user.spendings.all
  end

  def lastmonth
    @user = current_user
    @goals = @user.goals.all
    @spendings = @user.spendings.where(start_time: Time.current.all_month)
    @last_month = @user.spendings.where(start_time: Time.current.last_month.all_month)
    @chart = @last_month.joins(:genre).group("genres.name").sum(:spending_amount).sort_by {|_,v|v}.reverse.to_h
  end

  def show
    @spending = Spending.find(params[:id])
  end

  def new
    @spending = Spending.new
    @genres = Genre.all
    @user = current_user
    @spendings = @user.spendings.order(start_time: :desc)
  end

  def create
    @spending = Spending.new(spending_params)
    @spending.user_id = current_user.id
    if @spending.save
    redirect_to new_spending_path
    else
      render :new
    end
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
