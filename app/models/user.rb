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
end
