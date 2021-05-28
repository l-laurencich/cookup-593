class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:query].present?
      @events = policy_scope(Event)
      @events = Event.near(params[:query], 4)
      if @events.empty?
        redirect_to events_path, notice:"Sorry, we could not find any event in #{params[:query]}, but feel free to browse all the other events here!"
      end
    else
      @events = policy_scope(Event)
    end

    @markers = @events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        info_window: render_to_string(partial: "info_window", locals: { event: event }),
        image_url: helpers.asset_url('pizza_marker')
      }
    end
  end

  def my_bookings
    @bookings = Booking.where(user: current_user)
    authorize Event
  end

  def my_events
    @events = current_user.owned_events
    authorize Event
  end

  def show
  end

  def new
    @event = Event.new
    authorize @event
  end

  def create
    @event = Event.new(event_params)
    @user = current_user
    @event.user = @user
    authorize @event
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
    authorize @event
  end

  def event_params
    params.require(:event).permit(:start, :name, :menu, :location, :price, :capacity, :description, :dietary_requirements, :photo)
  end
end
