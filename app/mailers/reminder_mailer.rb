class ReminderMailer < ApplicationMailer

  default from: "noreply@jginfosys.com"
  layout 'mailer'


  def reminder_email

    mail(to: @user.email, subject: 'Books checked out reminder...')

  end


end
