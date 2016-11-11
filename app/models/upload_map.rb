class UploadMap < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  # security (i.e. attr_accessible) ...........................................
  mount_uploader :file, MapUploader

  # relationships .............................................................
  belongs_to :map

  belongs_to :user

  has_many :dots

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
    case self.content_type
    when 'application/octet-stream' # KML
      dots = kml_import
    end
    dots.each { |dot| self.dots.create dot.merge(user_id: self.user_id, map_id: self.map_id) }
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
      case [hash].flatten.length
      when 1
        [ hash ]
      else
        hash
      end
    end

    def kml_import
      hash = Hash.from_xml File.read(self.file_path)
      folder = hash['kml']['Document']['Folder']
      return [] if folder['Placemark'].blank?
      grub_dots(folder['Placemark']).compact.map do |dot|
        points  = dot['Point']['coordinates'].strip.split(',')[0..1]
        created = dot['TimeStamp']['when']
        { x: points[0], y: points[1], name: dot['name'], created_at: created }
      end
    end
end
