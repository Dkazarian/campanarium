class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :twitter]
  has_many :user_oauths, dependent: :destroy
  validates :name, presence: true, allow_blank: false
  has_one :avatar, class_name: "Media", as: :media_owner, dependent: :destroy
  accepts_nested_attributes_for :avatar
  def self.from_omniauth omniauth
    User.joins(:user_oauths).where(user_oauths: omniauth.slice(:provider, :uid)).readonly(false).first
  end

  def link_oauth oauth_data
    UserOauth.create!(uid: oauth_data["uid"], provider: oauth_data["provider"], user: self)
  end

  def unlink_provider provider
    has_oauth?(provider).try(:destroy)
  end

  def has_oauth? provider
    user_oauths.where(provider: provider).first
  end

  def has_password?
    has_password
  end

  def has_email?
    has_email
  end

  def has_many_oauths?
    user_oauths.count > 1
  end

  def admin?
    false
  end

  def banned?
    destroyed_at.present?
  end

  class << self
    def name_like(name)
      name.present? ? self.where("name ~* ?", name) : self.all
    end
  end
end
