class PlansController < ApplicationController
  def show
  end

  def new
    @plan=current_user.advisor.plans.new
  end

  def create
    @plan=current_user.advisor.plans.build(plan_params)
    if @plan.save
      flash[:success] = "プラン作成に成功しました"
    else
      flash[:danger] = "プラン作成に失敗しました"
      render "/users/:user_name/plans/new"
    end

    redirect_to user_profile_path(user_name: current_user.name)
  end

  def edit
    @plan = current_user.advisor.plans.find_by(id: params[:id])
  end

  def update
    @plan = current_user.advisor.plans.find_by(id: params[:id])
    if @plan.update(plan_params)
      flash[:success] = "プラン情報を編集しました"
      redirect_to user_profile_path(user_name: current_user.name)
    else
      flash.now[:danger] = "プラン情報の更新に失敗しました"
      render "users/:user_name/plans/:id/edit"
    end
  end


  private

  def plan_params
    params.require(:plan).permit(:id, :title, :description, :fee)
  end
end
