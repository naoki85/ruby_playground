class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:twitter]

  has_many :user_books, dependent: :destroy
  has_many :books, through: :user_books
  has_many :user_book_comments

  has_one_attached :image

  after_create :update_authentication_token!

  # @return bool
  def update_authentication_token!
    self.authentication_token = "#{self.id}:#{Devise.friendly_token}"
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

  # @return string
  def avatar_image(**options)
    return '' unless avatar_image?
    if image.attached?
      if options.present? && options.key?(:resize)
        url_for(image.variant(resize: options[:resize]))
      else
        url_for(image)
      end
    elsif image_url.present?
      image_url
    else
      'commons/default_user_icon.png'
    end
  end
end
