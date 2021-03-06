class Participant < ApplicationRecord
  before_create :check_pending
  before_create :check_the_rest

  belongs_to :user
  belongs_to :event
  belongs_to :event_language
  belongs_to :group

  private

  def check_pending
    self.pending = true if self.event.permission?
  end

  def check_the_rest
    event_language = self.event_language
    if event_language.max - event_language.participants.count == 0
      errors.add :base, 'イベントが満席になりました'
      throw :abort
    end
  end
end
