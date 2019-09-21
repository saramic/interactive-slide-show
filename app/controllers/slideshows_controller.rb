class SlideshowsController < ApplicationController
  include Clearance::Controller
  before_action :require_login

  def show
    @slideshow = Slideshow.find(params[:id])
  end
end
