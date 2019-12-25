class ProfilesController < ApplicationController
  before_action  :authenticate_user!

  def edit
  end

  def show
    @user=User.find_by(name: params[:user_name])
  end

  def update
  end
end
