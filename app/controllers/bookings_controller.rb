class BookingsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @booking = Booking.new
  end

  def create
    @event = Event.find(params[:event_id])
    @booking = Booking.new(booking_params)
    @booking.event = @event
    @booking.user = current_user
    if @booking.save
      redirect_to event_path(@event)
    else
      render "new"
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to event_path(@booking.event)
  end

  private

  def booking_params
    params.require(:booking).permit(:message, :event_id, :number_of_guests)
  end
end
