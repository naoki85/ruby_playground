class User < ApplicationRecord

  has_many :posts

  has_one_attached :image

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validate :valid_password

  attr_accessor :password

  #after_create :update_authentication_token!
  before_save :downcase_email

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
               BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.find_by_email_and_password(email, password)
    return nil unless email.present? && password.present?
    user = find_by(email: email)
    if user && correct_password?(user.encrypted_password, password)
      user.password = password
      user
    else
      nil
    end
  end

  def self.find_by_active_token(authentication_token)
    where(authentication_token: authentication_token).
        where("authentication_token_expired_at > ?", DateTime.now).first
  end

  def self.correct_password?(encrypted_password, password)
    BCrypt::Password.new(encrypted_password).is_password?(password)
  end

  # @param [Hash] params
  # @return [Bool]
  def update_with_image(params)
    self.username = params[:username]
    self.email = params[:email]
    self.password = params[:new_password]
    self.save && attach_image(params)
  end

  # @return [Bool]
  def update_authentication_token!
    self.authentication_token = generate_token(self.id)
    self.authentication_token_expired_at = DateTime.now + 1.week
    save!
  end

  # @return [Bool]
  def reset_authentication_token!
    self.authentication_token = ''
    self.authentication_token_expired_at = ''
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

  def valid_password
    return if !new_record? && !password.present?
    if password.present? && password.length >= 6
      self.encrypted_password = self.class.digest(password)
    else
      errors.add(:password, ': パスワードは6文字以上で指定してください')
    end
  end

  # @param [Integer]
  # @return [String]
  def generate_token(user_id)
    user_id = user_id || 0
    SecureRandom.alphanumeric(10) + format('%07d', user_id) + SecureRandom.alphanumeric(10)
  end
end
