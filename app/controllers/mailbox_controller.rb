class MailboxController < ApplicationController
  before_action :authenticate_user!

  def inbox
    @inbox_doctor = mailbox.inbox.select { |conversation| User.find(conversation.originator.id).role=="doctor"}
    @inbox_patient = mailbox.inbox.select { |conversation| User.find(conversation.originator.id).role=="patient"}
    @active = :inbox
  end

  def sent
    @sent_doctor = mailbox.sentbox.select { |conversation| User.find(conversation.originator.id).role=="doctor"}
    @sent_patient = mailbox.sentbox.select { |conversation| User.find(conversation.originator.id).role=="patient"}
    @active = :sent
  end

  def trash
    @trash_doctor = mailbox.trash.select { |conversation| User.find(conversation.originator.id).role=="doctor"}
    @trash_patient = mailbox.trash.select { |conversation| User.find(conversation.originator.id).role=="patient"}
    @active = :trash
  end

end