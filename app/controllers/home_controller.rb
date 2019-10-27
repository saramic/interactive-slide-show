class HomeController < ApplicationController
  def index
    redirect_to viewing_path(id: Viewing.first.id)
  end
end
