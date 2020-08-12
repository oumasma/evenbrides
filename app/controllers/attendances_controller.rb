class AttendancesController < ApplicationController
    before_action :find_event

    def create
        @event.attendances.create(user_id: current_user.id)
    end

    private

    def find_event
        @event = Event.find(params[:event_id])
    end
end
