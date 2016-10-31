xml.instruct!

xml.kml(xmlns: "http//www.opengis.net/kml/2.2", xmlnsgx: "http//www.google.com/kml/ext/2.2") do
  xml.Document do
    xml.Style(id: "pdfmaps_style_red") do
      xml.IconStyle do
        xml.Icon do
          xml.href "http//download.avenza.com/images/pdfmaps_icons/v2/pin-red-inground.png"
        end
      end
    end
    xml.Schema(id: "schema0", name: "schema0") do
      xml.SimpleField(name: "Description", type: "string")
      xml.SimpleField(name: "pdfmaps_photos", type: "string") do
        xml.displayName "Photos"
      end
    end
    xml.Folder do
      xml.name @map.title
      xml.ExtendedData do
        xml.SchemaData(schemaUrl: "#schema0")
      end
      @dots.each do |dot|
        xml.Placemark do
          xml.name dot.name
          xml.TimeStamp do
            xml.when dot.created_at.xmlschema
          end
          xml.styleUrl "#pdfmaps_style_red"
          xml.ExtendedData do
            xml.SchemaData(schemaUrl: "#schema0") do
              xml.SimpleData(name: "Description")
              xml.SimpleData(name: "pdfmaps_photos")
            end
          end
          xml.Point do
            xml.coordinates "#{dot.x},#{dot.y},0"
          end
        end
      end
    end
  end
end
