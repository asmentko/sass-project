class Artifact < ApplicationRecord
  attr_accessor :file
  belongs_to :project
  mount_uploader :file, FileUploader

  MAX_FILESIZE = 10.megabytes
  validates_presence_of :name, :file
  validates_uniqueness_of :name

  validate :uploaded_file_size

  private

  def uploaded_file_size
    if file
      errors.add(:file, "File size must be less than #{self.class::MAX_FILESIZE}") unless file.size <= self.class::MAX_FILESIZE
    end
  end
end
