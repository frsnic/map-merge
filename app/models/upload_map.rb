class UploadMap < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  # security (i.e. attr_accessible) ...........................................
  mount_uploader :file, MapUploader

  # relationships .............................................................
  belongs_to :map

  belongs_to :user

  # validations ...............................................................
  validates_presence_of :file, :map_id, :user_id

  # callbacks .................................................................
  before_save :update_attributes

  after_create :import_dots

  # scopes ....................................................................
  # additional config .........................................................
  # class methods .............................................................
  # public instance methods ...................................................
  def file_path
    self.file.path
  end

  def import_dots
    hash = Hash.from_xml File.read(self.file_path)
    grub_dots(hash['kml']['Document']['Folder']['Placemark']).compact.each do |dot|
      points = dot['Point']['coordinates'].strip.split(',')[0..1]
      self.map.dots.create(
        x: points[0],
        y: points[1],
        name: dot['name'],
        user_id: self.user_id,
        created_at: dot['TimeStamp']['when'],
        updated_at: dot['TimeStamp']['when']
      )
    end
  end

  # protected instance methods ................................................
  # private instance methods ..................................................
  private

    def update_attributes
      if file.present? && file_changed?
        self.name         = file.file.filename
        self.size         = file.file.size
        self.content_type = file.file.content_type
      end
    end

    def grub_dots(hash)
      case hash['Point'].length
      when 0
        []
      when 1
        [ hash ]
      else
        hash
      end
    end

end
