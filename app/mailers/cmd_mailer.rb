class CmdMailer < ApplicationMailer
  def send_cmd
    email = params[:email]
    @cmd = params[:cmds]
    mail(to: email, subject: 'You got a CMD')
  end
end