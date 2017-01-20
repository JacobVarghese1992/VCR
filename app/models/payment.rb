class Payment < ApplicationRecord
	belongs_to :appointment

	attr_accessor :card_number, :card_verification
end
