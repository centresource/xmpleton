require 'nokogiri'

module Xmpleton
  class Reader
    def initialize(image_file)
      binary_data = image_file.read
      xmp_start = binary_data.index '<x:xmpmeta'
      xmp_end = binary_data.index('</x:xmpmeta>')
      @xmp_data = binary_data[xmp_start..xmp_end + 11] if xmp_start and xmp_end
      @xml = Nokogiri::XML.parse(@xmp_data)
    end

    def tags
      tags = []
      subject = @xml.css("dc|subject", 'dc' => 'http://purl.org/dc/elements/1.1/')
      if subject && !subject.empty?
        items = subject.css("rdf|li", 'rdf' => 'http://www.w3.org/1999/02/22-rdf-syntax-ns#')
        tags = items.map { |i| i.text }
      end
      tags
    end
  end
end
