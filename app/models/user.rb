# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string
#  last_name              :string
#  phone_one              :string
#  phone_two              :string
#  d_o_b                  :datetime
#  gender                 :string           default("male")
#  role                   :string           default("patient")
#

class User < ApplicationRecord
  

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :role, :presence => true
  #validates :phone_one, :presence => true
  validates :first_name, :presence => true
  validates :last_name, :presence => true

  #devise validates presence of password and email
  acts_as_messageable

  def mailboxer_name
    self.first_name+" "+self.last_name
  end

  def mailboxer_email(object)
    self.email
  end

  has_many :active_contacts, class_name:  "ContactRelationship", foreign_key: "contacter_id", dependent: :destroy
  has_many :passive_contacts, class_name:  "ContactRelationship",  foreign_key: "contact_id",  dependent: :destroy

  has_many :contacts, through: :active_contacts,  source: :contact
  has_many :contacters, through: :passive_contacts, source: :contacter

  has_many :assets
  has_many :folders
  
  has_many :initiated_appts, class_name:  "Appointment", foreign_key: "initiator_id", dependent: :destroy
  has_many :received_appts, class_name:  "Appointment",  foreign_key: "receiver_id",  dependent: :destroy

  has_many :push_details

  #this is for folders which this user has shared 
  has_many :shared_folders, dependent: :destroy
  
#this is for folders which the user has been shared by other users 
  has_many :being_shared_folders, class_name: "SharedFolder", foreign_key: "shared_user_id", dependent: :destroy

  #this is for getting Folders objects which the user has been shared by other users 
has_many :shared_folders_by_others, through: :being_shared_folders, source: :folder


  def add_contact(other_user)
    active_contacts.create(contact_id: other_user.id)
  end

  def remove_contact(other_user)
    active_contacts.find_by(contact_id: other_user.id).destroy
  end

  # after_create :check_and_assign_shared_ids_to_shared_folders
  
# #this is to make sure the new user ,of which the email addresses already used to share folders by others, to have access to those folders 
# def check_and_assign_shared_ids_to_shared_folders     
#     #First checking if the new user's email exists in any of ShareFolder records 
#     shared_folders_with_same_email = SharedFolder.find_all_by_shared_email(self.email) 
  
#     if shared_folders_with_same_email       
#       #loop and update the shared user id with this new user id  
#       shared_folders_with_same_email.each do |shared_folder| 
#         shared_folder.shared_user_id = self.id 
#         shared_folder.save 
#       end
#     end    
# end

#to check if a user has acess to this specific folder 
def has_share_access?(folder) 
    
    if(!folder) 
      return true
    end  
    #has share access if the folder is one of one of his own 
    return true if self.folders.include?(folder) 
  
    #has share access if the folder is one of the shared_folders_by_others 
    return true if self.shared_folders_by_others.include?(folder) 
  
    #for checking sub folders under one of the being_shared_folders 
    return_value = false
  
    folder.ancestors.each do |ancestor_folder| 
    
      return_value = self.being_shared_folders.include?(ancestor_folder) 
      if return_value #if it's true 
        return true
      end
    end
  
    return false
end

end

