# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @answering_rooms = current_user.find_questioner
    @questioning_rooms = current_user.find_answerer
  end

  def show
    @room = Room.find(params[:id])
    @talks = Talk.where(room_id: @room.id)
  end
end
