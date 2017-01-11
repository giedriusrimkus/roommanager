class MessageMailer < ActionMailer::Base

  default from: "The Room Manager <no-reply@theroommanager.herokuapp.com>"
  default to: "Giedrius Rimkus <giedrius.rimkus.a@gmail.com>"

  def new_message(message)
    @message = message
    
    mail subject: "Message from #{message.name}"
  end

end