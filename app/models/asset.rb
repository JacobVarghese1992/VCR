class Asset < ApplicationRecord
	belongs_to :user
  # belongs_to :folder

#set up "uploaded_file" field as attached_file (using Paperclip) 
  
  has_attached_file :uploaded_file, #styles: { medium: "300x300>", thumb: "100x100#" },

                    :url => "/assets/get/:id", 
                    :path => ":Rails_root/assets/:id/:basename.:extension"

  #validates_attachment_presence :uploaded_file
  #validates :uploaded_file, attachment_presence: true

  #Only presence validation not working, have to give a file type, why?

  # validates_attachment_content_type :uploaded_file, content_type: [/\Aimage\/.*\z/, "application/pdf","application/vnd.ms-excel",     
  #            "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
  #            "application/msword", 
  #            "application/vnd.openxmlformats-officedocument.wordprocessingml.document", 
  #            "text/plain"]

  validates_attachment_content_type :uploaded_file, content_type:[]

  def file_name 
    uploaded_file_file_name 
  end

  def file_size 
    uploaded_file_file_size 
  end

  def folder
    if self.folder_id
    return Folder.find(self.folder_id)
    end
  end  
end

