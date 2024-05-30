require 'sidekiq/scheduler'

Sidekiq.configure_server do |config|
  config.on(:startup) do
    Sidekiq.schedule = {
      'session_update' => {
        'cron' => '*/3 * * * *',
        'class' => 'SessionUpdateJob'
      }
    }
    Sidekiq::Scheduler.reload_schedule!
  end
end
