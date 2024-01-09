class Link
  include Mongoid::Document
  include Mongoid::Timestamps

  field :view_count, type: Integer, default: 0
  field :password_digest, type: String
  field :original_url, type: String
  field :slug, type: String

  validates :original_url, presence: true
  validates :slug, uniqueness: true, presence: true

  index({ slug: 1 }, { unique: true })

  before_validation :generate_unique_slug

  private

  def generate_unique_slug
    loop do
      self.slug = generate_random_slug
      break unless Link.where(slug: self.slug).exists?
    end
  end

  def generate_random_slug
    SecureRandom.urlsafe_base64(4)
  end

  def password=(new_password)
    self.password_digest = BCrypt::Password.create(new_password) if new_password.present?
  end

  def authenticate(password)
    BCrypt::Password.new(password_digest) == password if password_digest.present?
  end
end
