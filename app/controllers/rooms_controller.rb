# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @answering_rooms = current_user.find_questioner
    @questioning_rooms = current_user.find_answerer
  end

  def show
    @room = Room.find(params[:id])
    @talks = Talk.where(room_id: @room.id).to_json
    @member = @room.find_member(current_user.id)
  end

  def create
    room=Room.find_by(room_params)
    if room
      redirect_to room_path(id: room.id)
    else
      @room = Room.create(room_params)
      if @room.save
        flash[:success] = t("users.flash.create.success", item: "チャット")
        redirect_to room_path(id: @room.id)
      else
        flash[:danger] = t("users.flash.create.danger", item: "チャット")
      end
    end
  end

  private

  def room_params
    params.require(:room).permit(:answerer_id, :questioner_id)
  end
end
