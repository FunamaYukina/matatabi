# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def edit
  end

  def show
    @user = User.find_by(name: params[:user_name])
  end

  def update
    if current_user.profile.update(profile_params)
      flash[:success] = "ユーザー情報を編集しました"
      redirect_to user_profile_path
    else
      flash.now[:danger] = "ユーザー情報の更新に失敗しました"
      render "settings/profiles/edit"
    end
  end

  private

    def profile_params
      params.require(:profile).permit(:introduction_title, :introduction, :place, :image_file)
    end
end
