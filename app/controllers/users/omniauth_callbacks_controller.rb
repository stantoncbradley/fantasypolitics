class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => 'Facebook') if is_navigational_format?
    else
      @user = User.by_email(request.env['omniauth.auth'].info.email).first

      unless @user.nil?
        @user.password = Devise.friendly_token[0,20]
        @user.provider = request.env['omniauth.auth'].provider
        @user.uid = request.env['omniauth.auth'].uid
        @user.save!
      else
        @user = User.create!({
                                 email: request.env['omniauth.auth'].info.email,
                                 password: Devise.friendly_token[0,20],
                                 provider: request.env['omniauth.auth'].provider,
                                 uid: request.env['omniauth.auth'].uid
                             })
        CreateDemoTeamService.execute(@user)
      end

      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => 'Facebook') if is_navigational_format?
    end
  end
end