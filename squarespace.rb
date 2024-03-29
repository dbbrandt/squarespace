require 'nokogiri'
require 'json'

require './artwork.rb'

class Wordpress
  attr_accessor :xml, :categories, :artworks

  def initialize(file = "")

    xml_file = File.read(file)

    @xml = Nokogiri::XML.parse(xml_file)

    category_elements = xml.xpath("//item[wp:post_type = 'page']")
    item_pages = category_elements.map { |c| c.children.select { |e| e.name == 'title'}.first.children.first.text }
    category_names = item_pages.select { |i| i =~ /Gallery/ }
    category_names.map! { |n| n[0..-9] }
    category_ids = category_elements.map { |c| c.children.select { |e| e.name == 'post_id'}.first.children.first.text }

    @categories = Hash[category_names.zip category_ids]

    artwork_elements = xml.xpath("//item[wp:post_type = 'attachment']")
    @artworks = artwork_elements.map { |e| Artwork.new(e) }

  end

  # return all element_ids for parent element_id
  def category_id(name)
     @categories[name]
  end

  def category_name(id)
    @categories.key(id)
  end

   def artworks_by_category(category_id)
     works = @artworks.select {|a| a.category_id  == category_id }
     works.each { |w| w.category_name = category_name(w.category_id) }
     works
   end

end
