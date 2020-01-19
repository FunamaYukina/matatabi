# frozen_string_literal: true

class TalksController < ApplicationController
  before_action :authenticate_user!

  def index
    @talks_data = Talk.where(room_id: params[:room_id]).to_json
    render json: {talks: @talks_data}
  end

  def create
    @talk = current_user.talks.build(talk_params)

    if @talk.save
      render json: { data: @talk}
    else
      # render "rooms/show"
      render json: {status: 'FAILED', message: 'Loaded the post', data: "hello"}
    end
  end

  def update
  end

  private

  def talk_params
    params.require(:talk).permit(:talk_content, :room_id)
  end
end
