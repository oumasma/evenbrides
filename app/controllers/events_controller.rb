class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]

  def index
  end

  def show
    @event = Event.find(params[:id])
    puts @event
  end
  
  def new 
  	@event = Event.new
  end 

  def create
    @event = Event.new('title' => params[:event_title], 'location' => params[:event_location], 'description' => params[:event_description], 'start_date' => params[:event_date], 'price' => params[:event_price].to_i, 'duration' => params[:event_duration].to_i)
    @event.admin = current_user
    
    if @event.save
      redirect_to events_path, notice: "L'événement #{@event.title} a bien été créé ! Bien joué petit génie !"
    else
      redirect_to new_event_path, alert: "Certaines informations sont incorrectes : la description doit faire au moins 20 caractères et la date doit être dans le futur. "
    end
  end
  
  private

  def authenticate_current_user
    unless current_user == Event.find(params[:id]).user
      redirect_to events_path(params[:id]), alert: "Vous ne pouvez pas modifier cet évenement"
    end
  end
end
