class SlidesController < ApplicationController
  include Clearance::Controller
  before_action :require_login

  def show
    @current_slide = Slide.find(params[:id])
    render template: "slideshows/show"
  end
end
