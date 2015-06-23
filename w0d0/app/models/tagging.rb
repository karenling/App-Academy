class Tagging < ActiveRecord::Base
  belongs_to(
    :tag,
    class_name: 'Tag',
    foreign_key: :tag_id,
    primary_key: :id
  )
  belongs_to(
   :article,
   class_name: 'Article',
   foreign_key: :article_id,
   primary_key: :id
  )
end
