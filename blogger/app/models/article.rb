class Article < ActiveRecord::Base
  has_many(
   :comments,
   class_name: 'Comment',
   foreign_key: :article_id,
   primary_key: :id
   )

  has_many(
    :taggings,
    class_name: 'Tagging',
    foreign_key: :article_id,
    primary_key: :id
   )

  has_many(
    :tags,
    through: :taggings,
    source: :tag
  )




  def tag_list
    tags.join(", ")
  end

  # def tag_list
  #   self.tags.collect do |tag|
  #     tag.name
  #   end.join(", ")
  # end

  def tag_list=(tags_string)
    tag_names = tags_string.split(",").map do |s|
      s.strip.downcase
    end.uniq
    new_or_found_tags = tag_names.map do |name|
      Tag.find_or_create_by(name: name)
    end

    self.tags = new_or_found_tags
  end
end
