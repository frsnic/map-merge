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
    # KML
    when 'application/octet-stream'
      dots = kml_import
    # CSV
    when 'text/csv'
      dots = csv_import
    else
      dots = []
    end
    dots.each { |dot| self.dots.create dot.merge(user_id: self.user_id, map_id: self.map_id) }
  end

  # protected instance methods ................................................
  # private instance methods ..................................................
  private
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
        desc    = dot['ExtendedData'].try(:[], 'SchemaData').try(:[], 'SimpleData')
        { x: points[0], y: points[1], name: dot['name'], desc: desc, created_at: created }
      end
    end

    def csv_import
      require 'csv'

      csv_text = File.read(self.file_path)
      csv = CSV.parse(csv_text, headers: true)
      csv.map do |row|
        { x: row[3], y: row[2], name: row[0], desc: row[6], created_at: row[1] }
      end
    end
end
