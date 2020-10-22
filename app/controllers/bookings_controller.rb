class BookingsController < ApplicationController
  def new
    @venue = Venue.find(params[:venue_id])
  end

  def create
    @venue = Venue.find(params[:venue_id])
    @booking = @venue.bookings.new(booking_params)
    user = current_user
    @booking.user = user
    @booking.save
    redirect_to venue_path(@venue)
  end

  private
    def booking_params
      params.require(:booking).permit(:from, :to)
    end

  def edit
  end

  def update
  end

  def destroy
  end
end
