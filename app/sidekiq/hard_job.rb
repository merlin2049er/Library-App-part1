class HardJob
  include Sidekiq::Job

  def perform(*args)
    # Do something
    puts"okaaaaaaaaaaaaaaaa"
    DailycheckoutreminderMailerJob.perform_now
  end
end
