class ShortenedUrl < ApplicationRecord
  validates :long_url, presence: true
  validates :short_url, uniqueness: true
  belongs_to :submitter, class_name: 'User', foreign_key: :user_id
  has_many :visits, class_name: 'Visit', foreign_key: :shortened_url_id
  has_many :visitors, Proc.new {distinct}, through: :visits, source: :visitor

  def random_code
    random = SecureRandom.urlsafe_base64(16)
    while ShortenedUrl.exists?(short_url: random)
      random = SecureRandom.urlsafe_base64(16)
    end
    random
  end
  
  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    visitors.where('visits.created_at > ?', 10.minutes.ago).count

  end

  def factory_method(user, long_url)
    ShortenedUrl.create(user_id: user.id, long_url: long_url, short_url: random_code)
  end

  end
