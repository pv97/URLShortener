# == Schema Information
#
# Table name: shortened_urls
#
#  id        :integer          not null, primary key
#  short_url :string
#  user_id   :integer
#  long_url  :string


require 'securerandom'

class ShortenedUrl < ActiveRecord::Base
  validates :short_url, :long_url, :user_id, presence: true
  validates :long_url, uniqueness: true
  validate :length_validation

  def length_validation
    if self.long_url.length > 1000
      self.errors[:too] << "long"
    end
  end

  def self.prune

  end

  def self.random_code
    code = SecureRandom.urlsafe_base64
    while ShortenedUrl.find_by(short_url: code)
      code = SecureRandom.urlsafe_base64
    end
    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    if user.links_created < 5 || user.premium
      self.create!(user_id: user.id, long_url: long_url, short_url: random_code)
    else
      puts "Please give us money for premium Boolean service. thank you."
    end
  end

  def num_clicks
    recent_visits = self.visits.select { |visit| true }
    p recent_visits
    recent_visits.uniq.size
  end

  belongs_to :submitter,
    class_name: :User,
    primary_key: :id,
    foreign_key: :user_id

  has_many :visits,
    class_name: :Visit,
    primary_key: :id,
    foreign_key: :shortened_url_id

  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :user

  has_many :taggings,
    class_name: :Tagging,
    primary_key: :id,
    foreign_key: :shortened_url_id

  has_many :tag_topics,
    through: :taggings,
    source: :tag_topic

end
