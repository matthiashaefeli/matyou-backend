class ReminderMailer < ApplicationMailer
  def reminder_mail
    @cmds = params[:cmds]
    mail(to: 'mat@matyou.net', subject: 'You got a learning reminder'
  end
end
