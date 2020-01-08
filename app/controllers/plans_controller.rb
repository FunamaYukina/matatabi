class PlansController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def new
    @plan=current_user.advisor.plans.new
  end

  def create
    @plan=current_user.advisor.plans.build(plan_params)
    if @plan.save
      flash[:success] = t 'users.flash.plan.create.success'
    else
      flash[:danger] = t 'users.flash.plan.create.danger'
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
      flash[:success] = t 'users.flash.plan.update.success'
      redirect_to user_profile_path(user_name: current_user.name)
    else
      flash.now[:danger] = t 'users.flash.plan.update.danger'
      render "users/:user_name/plans/:id/edit"
    end
  end


  private

  def plan_params
    params.require(:plan).permit(:id, :title, :description, :fee)
  end
end
