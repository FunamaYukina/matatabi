# frozen_string_literal: true

class HomeController < ApplicationController
  layout "top", only: :top

  def top
  end

  def index
    @plans = Plan.where(advisor_id:2)
  end
end
