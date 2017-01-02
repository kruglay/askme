module TagsHelper
  #return text with references to hashtags
  def get_text_with_hashtags(text)
    text.gsub(/#[\w]+/).each do |tag|
      tag_text = tag.downcase.delete('#')
      tag_record = Tag.find_by(title: tag_text)
      link_to_if(tag_record.present?, tag, tag_path(tag_record), class: 'tag')
    end
  end
end
