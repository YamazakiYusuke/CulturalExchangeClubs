class ParticipantsController < ApplicationController
  def create
    group = Event.find(params[:event_id]).group
    if params[:guest] == "false" && !group.users.include?(current_user)
      @participant = current_user.participants.build(participant_params)
      if @participant.save
        current_user.members.create!(group_id:group.id)
        redirect_to event_path(params[:event_id]), notice: "イベントとグループに参加リクエストを送りました！\n現在のステータスをご確認ください"
      else
        redirect_to event_path(params[:event_id]), notice: "参加リクエストが送れませんでした"
      end
    else
      @participant = current_user.participants.build(participant_params)
      if @participant.save
        redirect_to event_path(params[:event_id]), notice: "イベントに参加リクエストを送りました！\n現在のステータスをご確認ください"
      else
        redirect_to event_path(params[:event_id]), notice: "参加リクエストが送れませんでした"
      end
    end
  end

  def destroy
  end

  private

  def participant_params
    params.permit(:event_id, :language_id, :guest)
  end
end