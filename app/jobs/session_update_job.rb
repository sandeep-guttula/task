class SessionUpdateJob < ApplicationJob
  # push the instances into default queue
  queue_as :default
  # method to update active sessions where expires_at time has passed
  # entry point
  def perform(*args)
    UserActiveSession.where("session_expiry < ? AND status = ?", Time.current.utc, true).update_all(status: false)
  end
end
