class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

    has_many :teams
    has_many :leagues, through: :teams

  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first

    if user.nil?
      user = User.create!({
        email: auth.info.email,
        password: Devise.friendly_token[0,20],
        provider: auth.provider,
        uid: auth.uid
      })
      
      CreateDemoTeamService.execute(user)
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end
end
