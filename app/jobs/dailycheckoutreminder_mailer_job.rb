class DailycheckoutreminderMailerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    User.find_each do |user|
      ReminderMailer.with(user: user, fact: CatfactServices::Catfact.new.daily_fact).daily_catfact.deliver_now
    end
  end
end
