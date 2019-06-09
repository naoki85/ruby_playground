class User < ApplicationRecord
  has_many :posts

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validate :valid_password

  attr_accessor :password

  # after_create :update_authentication_token!
  before_save :downcase_email

  def self.digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost: cost)
  end

  def self.find_by_email_and_password(email, password)
    return nil unless email.present? && password.present?
    user = find_by(email: email)
    return nil unless user && !user.locked? && correct_password?(user.encrypted_password, password)
    user.password = password
    user
  end

  def self.find_by_active_token(authentication_token)
    where(authentication_token: authentication_token)
      .where("authentication_token_expired_at > ?", DateTime.now).first
  end

  def self.correct_password?(encrypted_password, password)
    BCrypt::Password.new(encrypted_password).is_password?(password)
  end

  # @param [Hash] params
  # @return [Bool]
  def update_with_image(params)
    self.username = params[:username] if params[:username]
    self.email = params[:email] if params[:email]
    self.password = params[:new_password] if params[:new_password]
    self.image_url = get_image_url(params[:image]) if params[:image]
    save
  end

  # @return [Bool]
  def update_authentication_token!
    self.authentication_token = generate_token(id)
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

  def locked?
    locked_at && locked_at + 1.hour > DateTime.now
  end

  private

  def downcase_email
    email.downcase!
  end

  def valid_password
    return if !new_record? && password.blank?
    if password.present? && password.length >= 6
      self.encrypted_password = self.class.digest(password)
    else
      errors.add(:password, ': パスワードは6文字以上で指定してください')
    end
  end

  # @param [Integer]
  # @return [String]
  def generate_token(user_id)
    user_id ||= 0
    SecureRandom.alphanumeric(10) + format('%07d', user_id) + SecureRandom.alphanumeric(10)
  end

  def get_image_url(image)
    return image_url unless image.present?
    image_file_name = upload_klass.upload(image.tempfile, image.original_filename, {})
    BookRecorder::Application.config.image_base_url + image_file_name
  end

  def upload_klass
    @upload_klass ||= AwsS3::Resource.new
  end
end
