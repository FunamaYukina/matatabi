# frozen_string_literal: true

class TalksController < ApplicationController
  before_action :authenticate_user!

  def index
    @talks_data = Talk.where(room_id: 2).to_json
    render json: {talks: @talks_data}
  end

  def create
    # binding.pry
    @talk = current_user.talks.build(talk_params)

    if @talk.save
      # flash[:success] = t("users.flash.create.success", item: "プラン")
      render json: { data: @talk}
    else
      # flash[:danger] = t("users.flash.create.danger", item: "プラン")
      # render "rooms/show"
      render json: {status: 'FAILED', message: 'Loaded the post', data: "hello"}
      # binding.pry
    end
  end

  def update
  end

  private

  def talk_params
    params.require(:talk).permit(:talk_content, :room_id)
  end
end
