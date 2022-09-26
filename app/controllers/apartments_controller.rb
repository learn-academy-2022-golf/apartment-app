class ApartmentsController < ApplicationController

  def index
    apartment = Apartment.all
    render json: apartment
  end

end
