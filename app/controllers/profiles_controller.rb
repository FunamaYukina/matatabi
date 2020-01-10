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
      flash[:success] = t("users.flash.update.success", item: "ユーザー情報")
      redirect_to user_profile_path
    else
      flash.now[:danger] = t("users.flash.update.danger", item: "ユーザー情報")
      render "settings/profiles/edit"
    end
  end

  private

    def profile_params
      params.require(:profile).permit(:introduction_title, :introduction, :place, :image_file)
    end
end
