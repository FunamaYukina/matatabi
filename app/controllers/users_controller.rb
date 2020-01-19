# frozen_string_literal: true

class UsersController < ApplicationController
  # before_action :authenticate_user!

  def search
    @plans = Plan.search(params[:name])
    @name = params[:name]
  end

  def contract
    @user = User.find_by(name: params[:user_name])
  end
end
