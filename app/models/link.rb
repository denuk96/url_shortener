class Link
  include Mongoid::Document
  include Mongoid::Timestamps

  field :view_count, type: Integer, default: 0
  field :password_digest, type: String
  field :original_url, type: String
  field :slug, type: String

  validates :original_url, presence: true, format: { with: URI.regexp }
  validates :slug, uniqueness: true, presence: true
  validates :password_digest, presence: true

  index({ slug: 1 }, { unique: true })

  before_validation :generate_unique_slug

  def self.search(term)
    regex = /#{Regexp.escape(term)}/i
    any_of({ slug: regex }, { original_url: regex })
  end

  def increment_view!
    update(view_count: view_count + 1)
  end

  def authenticate(password)
    BCrypt::Password.new(password_digest) == password if password_digest.present?
  end

  private

  def generate_unique_slug
    return if slug

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
end
