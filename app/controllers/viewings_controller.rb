class ViewingsController < ApplicationController
  include Clearance::Controller
  before_action :require_login

  def show
    viewing = Viewing.find(params[:id])
    viewing
      .viewers
      .where(user_id: current_user.id).first ||
      viewing
        .viewers << Viewer.new(viewer: current_user)
  end
end
