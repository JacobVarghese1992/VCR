class ContactRelationship < ApplicationRecord
	belongs_to :contacter, class_name: "User"
	belongs_to :contact,   class_name: "User"
	validates :contacter_id, presence: true
  	validates :contact_id, presence: true
end
