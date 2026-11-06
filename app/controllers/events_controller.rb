class EventsController < ApplicationController
  before_action :authorize, except: %i[ show index ]
  before_action :set_event, only: %i[ show edit update destroy ]

  # GET /events or /events.json
  def index
    @events = Event.all
  end

  # GET /events/1 or /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to root_path, notice: "Event was successfully created." }
        format.json { render :no_content }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @event.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to root_path, notice: "Event was successfully updated.", status: :see_other }
        format.json { render :no_content }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @event.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def join
    guest = @event.guests.build(user_id: session[:user_id])
    respond_to do |format|
      if guest.save
        format.html { redirect_to @event, notice: "You have joined the #{@event.name} event!", status: :see_other }
        format.json { head :no_content }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @event.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy!

    respond_to do |format|
      format.html { redirect_to events_path, notice: "Event was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params[:event][:host_id] = session[:user_id]
      params.expect(event: [ :name, :location, :date, :host_id ])
    end
end
