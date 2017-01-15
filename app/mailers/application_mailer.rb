class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@theroommanager.herokuapp.com"
  layout 'mailer'
end
