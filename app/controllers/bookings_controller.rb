class BookingsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @booking = Booking.new
    authorize @booking
  end

  def create
    @event = Event.find(params[:event_id])
    @booking = Booking.new(booking_params)
    @booking.event = @event
    @booking.user = current_user
    authorize @booking
    if @booking.save
      redirect_to event_path(@event)
    else
      render "new"
    end
  end

  def update
    raise
  end

  def destroy
    @booking = Booking.find(params[:id])
    authorize @booking
    @booking.destroy
    redirect_to event_path(@booking.event)
  end

  private

  def booking_params
    params.require(:booking).permit(:message, :event_id, :number_of_guests, :status)
  end
end
