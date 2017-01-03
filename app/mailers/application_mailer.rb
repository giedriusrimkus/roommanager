class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@roommanager.com"
  layout 'mailer'
end
