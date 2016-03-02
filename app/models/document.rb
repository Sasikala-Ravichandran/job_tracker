class Document < ActiveRecord::Base

  belongs_to :user
  validates_presence_of :name
  validates_length_of :name, maximum: 30, minimum: 5

  mount_uploader :resume, ResumeUploader
end