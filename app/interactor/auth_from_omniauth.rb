class AuthFromOmniauth
  include Interactor
  def call
    auth = context.auth
    user = User.where(provider: auth.provider, uid: auth.uid).first
    if user.present?
      user 
    else
      user_with_email = User.find_by_email(auth.info.email)
      if user_with_email.present?
        if user_with_email.provider == auth.provider
          user = user_with_email
        else
          user = nil
        end
      else
        user = User.new
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.nickname = auth.info.name + rand(1..10000).to_s
        user.password = Devise.friendly_token[0,20]
        case auth.provider 
          when 'facebook'
            user.first_name = auth.info.name.split(' ')[0]
            user.second_name = auth.info.name.split(' ')[1]
          when 'github'
            user.first_name = 'git'
            user.second_name = 'git'
        end
        user.save
      end
    end
    context.user = user
  end
end