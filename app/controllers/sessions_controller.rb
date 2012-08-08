class SessionsController < ApplicationController
  
  def request_id    
    #Send request to get ID
    qb_oauth_consumer = OAuth::Consumer.new(QB_KEY, QB_SECRET, {
        :site                 => "https://oauth.intuit.com",
        :request_token_path   => "/oauth/v1/get_request_token",
        :authorize_url        => "https://appcenter.intuit.com/Connect/Begin",
        :access_token_path    => "/oauth/v1/get_access_token"
    })
    
    @callback_url = "/oauth/callback"

    @request_token = qb_oauth_consumer.get_request_token(:oauth_callback => @callback_url)
    session[:request_token] = @request_token
    redirect_to @request_token.authorize_url(:oauth_callback => @callback_url)
    
    #oauth_client = OAuth::AccessToken.new(qb_oauth_consumer, access_token, access_secret)
  end
  
  def callback
    @access_token = @request_token.get_access_token
    #@photos = @access_token.get('/photos.xml')
  end
  
  
end