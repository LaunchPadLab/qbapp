class User < ActiveRecord::Base
  attr_accessible :access_token, :email, :realmID, :access_secret
  
  def self.find_or_create_by_oauth_token(params, access_token)
    user = User.where(:access_token => access_token.token).first
    unless user
      user = User.create(access_token: access_token.token,
                         access_secret: access_token.secret,
                         realmID: params[:realmId])
    end
    user
  end
  
  
end
