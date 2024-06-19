class MapController < ApplicationController
  def show
    @locations = Location.all.to_json(only: [:latitude, :longitude])
  end
end
