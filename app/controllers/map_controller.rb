class MapController < ApplicationController
  before_action :authenticate_user!

  def show
    @locations = Location.all.to_json(only: [:latitude, :longitude])
  end
end
