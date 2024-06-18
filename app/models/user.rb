class User < ApplicationRecord
  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :website, presence: true
  validates :phone, presence: true, uniqueness: true
  validates_with AddressValidator
  validates_with CompanyValidator

  has_many :albums, dependent: :destroy
  has_many :photos, through: :albums

  def avatar
    AvatarService.fetch_avatar_url(id)
  end
end
