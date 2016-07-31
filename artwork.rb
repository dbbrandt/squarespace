class Artwork

  attr_accessor :category_id, :title, :image_url, :category_name

  def initialize(element)
    #LOGGER.debug "Element: #{element}"
    @category_id = element.children.select { |e| e.name == 'post_parent'}.first.children.first.text
    @title =  element.children.select { |e| e.name == 'post_name'}.first.children.first.text
    @image_url = element.children.select { |e| e.name == 'link'}.first.children.first.text
  end


end