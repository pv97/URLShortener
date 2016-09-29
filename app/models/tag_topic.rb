# == Schema Information
#
# Table name: tag_topics
#
#  id         :integer          not null, primary key
#  tag        :string
#  created_at :datetime
#  updated_at :datetime
#

class TagTopic < ActiveRecord::Base
  validates :tag, presence: true

  has_many :taggings,
    class_name: :Tagging,
    primary_key: :id,
    foreign_key: :tag_topic_id

  has_many :shortened_urls,
    through: :taggings,
    source: :shortened_url

end
