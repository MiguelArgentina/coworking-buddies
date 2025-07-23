module EventParticipationsHelper
  def attending?(event)
    user_signed_in? && event.event_participations.exists?(user: current_user)
  end
end
