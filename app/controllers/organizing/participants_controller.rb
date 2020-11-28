class Organizing::ParticipantsController < ApplicationController
  before_action :authenticate_user!
  before_action :any_organizer, only: [:accept_all_participants]

  before_action :set_participant, only: [:update, :deny]
  before_action :event_organizer_only, only: [:update, :deny]

  def update
    @participant.update!(pending:false)
    redirect_to organizing_path, notice: 'イベント参加を許可しました'
  end

  def deny
    @participant.destroy!
    redirect_to organizing_path, notice: 'イベント参加を却下しました'
  end

  def accept_all_participants
    Participant.where(event_id: current_user.organizing_events.pluck(:id), pending: true).update_all(pending:false)
    redirect_to organizing_path, notice: 'すべてのイベント参加を許可しました'
  end

  private

  def set_participant
    @participant = Participant.find(params[:id])
  end

  def event_organizer_only
    unless @participant.event.user_id == current_user.id
      redirect_to "/", notice: "イベントのオーガナイザーのみアクセスできます"
    end
  end
end
