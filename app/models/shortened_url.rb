class ShortenedUrl < ApplicationRecord
  validates :long_url, presence: true
  validates :short_url, uniqueness: true
  belongs_to :submitter, class_name: 'User', foreign_key: :user_id

  def random_code(long_url)
    random = SecureRandom.urlsafe_base64(16)
    while ShortenedUrl.exists?(short_url: random)
      random = SecureRandom.urlsafe_base64(16)
    end
    random
  end

end
