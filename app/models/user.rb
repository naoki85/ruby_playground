class User < ApplicationRecord

  has_many :user_books, dependent: :destroy
  has_many :books, through: :user_books
  has_many :user_book_comments

  has_one_attached :image

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }

  attr_accessor :password
  #after_create :update_authentication_token!
  before_save :encrypt_password
  before_save :downcase_email

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
               BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.find_by_email_and_password(email, password)
    return nil if email.empty? || password.empty?
    user = User.find_by(email: email)
    if user && correct_password?(user.encrypted_password, password)
      user.password = password
      user
    else
      nil
    end
  end

  def self.correct_password?(encrypted_password, password)
    BCrypt::Password.new(encrypted_password).is_password?(password)
  end

  # @return bool
  def update_authentication_token!
    self.authentication_token = generate_token(self.id)
    self.authentication_token_expired_at = DateTime.tomorrow
    save!
  end

  # @return bool
  def from_social?
    provider.present? && uid.present?
  end

  # @param hash { image: 'test_file' }
  # @return bool | ActiveStorage
  def attach_image(params)
    if params.key?(:image) && params[:image].present?
      logger.info params[:image]
      image.attach(params[:image])
    else
      return true
    end
  end

  private

  def downcase_email
    email.downcase!
  end

  def encrypt_password
    self.encrypted_password = self.class.digest(password)
  end

  # @param [Integer]
  # @return [String]
  def generate_token(user_id)
    user_id = user_id || 0
    SecureRandom.alphanumeric(10) + format('%07d', user_id) + SecureRandom.alphanumeric(10)
  end
end
