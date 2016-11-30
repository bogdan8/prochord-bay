class User < ApplicationRecord
  after_create :assign_default_role
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable

  rolify

  has_many :likes
  has_many :user, through: :likes

  @@user_password = "prochord#{rand(30..10500)}"

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email unless auth.info.email.nil?
      user.password = @@user_password
      user.skip_confirmation!
      UserMailer.send_password_to_user(user, @@user_password).deliver_now! unless auth.info.email.nil?
    end
  end

  def self.new_with_session(params, session)
    if session['devise.user_attributes']
      new(session['devise.user_attributes']) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def assign_default_role
    add_role(:user)
  end
end
