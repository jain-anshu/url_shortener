class Visit < ApplicationRecord
  validates :visitor_id, presence: true
  validates :shortened_url_id, presence: true
  belongs_to :visitor, class_name: 'User', foreign_key: :visitor_id
  belongs_to :shortened_url, class_name: 'ShortenedUrl', foreign_key: :shortened_url_id

  def record_visit!(user, shortened_url)
    Visit.create(visitor_id: user.id, shortened_url_id: shortened_url.id)
  end
end
