class EventsController < ApplicationController

  def index
    @events = Event.where('schedule >= ?', Time.zone.now).order(schedule: "ASC").limit(20)
    @index_date = 0
  end

  def show
    @event = Event.find(params[:id])
    @group = @event.group
    @organizer = @event.user
    @organizers = @group.organized_users
    @event_languages = @event.event_languages
  end
end
