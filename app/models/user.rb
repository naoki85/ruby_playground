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

  # @return bool
  def update_authentication_token!
    # self.authentication_token = "#{self.id}:#{Devise.friendly_token}"
    save
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
  # 一意となり得るuser_codeを生成する
  # @param  [Integer] ユーザID
  # @return [String]  ユーザコード
  def generate_user_code(user_id)
    user_id = user_id || 1
    trans_map = { 0=>5, 1=>7, 2=>6, 3=>4, 4=>9, 5=>2, 6=>3, 7=>0, 8=>1, 9=>8 }

    user_code = ''
    base_code = rand(10).to_s + format('%07d', user_id) + rand(10).to_s
    split_code = base_code.split(//)
    split_code.each_with_index do |code, i|
      user_code += trans_map[code.to_i].to_s
    end

    split_code = user_code.split(//).reverse
    user_code = ''
    split_code.each_with_index do |code, i|
      user_code += rand(10).to_s if i == 5
      user_code += trans_map[code.to_i].to_s
    end

    user_code
  end

  private

  def downcase_email
    email.downcase!
  end

  def encrypt_password
    self.encrypted_password = self.class.digest(password)
  end
end
