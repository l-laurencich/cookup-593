class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    if params[:query].present?
      @events = Event.all
      @events = @events.find_query(params[:query])if params[:query].present?
      if @events.empty?
        redirect_to events_path, notice:"Sorry, we could not find any event in #{params[:query]}, but you can create your own event!"
      end
    else
      @events = Event.all
    end

    @markers = @events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        info_window: render_to_string(partial: "info_window", locals: { event: event })
      }
    end
  end

  def my_bookings
    @bookings = Booking.where(user: current_user)
  end

  def my_events
    @events = current_user.owned_events
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @user = current_user
    @event.user = @user
    if @event.save
      redirect_to event_path(@event)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @event.update(event_params)

    redirect_to event_path(@event)
  end

  def destroy
    @event.destroy

    redirect_to events_path
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:start, :name, :menu, :location, :price, :capacity, :description, :dietary_requirements )
  end
end
