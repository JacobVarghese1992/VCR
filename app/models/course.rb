class Course < ApplicationRecord
  #this is for folders which this user has shared 
  has_many :registrations 
  has_many :users, through: :registrations

end
