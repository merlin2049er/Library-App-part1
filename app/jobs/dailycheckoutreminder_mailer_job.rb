class DailycheckoutreminderMailerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    User.all.each do |user|
      ReminderMailer.with(user: user).reminder_email.deliver_now
    end
  end
end
