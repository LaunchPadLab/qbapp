class SessionsController < ApplicationController
  
  def request_id    
    #Send request to get ID
    qb_oauth_consumer = OAuth::Consumer.new(QB_KEY, QB_SECRET, {
        :site                 => "https://oauth.intuit.com",
        :request_token_path   => "/oauth/v1/get_request_token",
        :authorize_url        => "https://appcenter.intuit.com/Connect/Begin",
        :access_token_path    => "/oauth/v1/get_access_token"
    })
    @request_token = qb_oauth_consumer.get_request_token
    puts @request_token.inspect
    session[:request_token] = @request_token
    redirect_to @request_token.authorize_url
    
    #oauth_client = OAuth::AccessToken.new(qb_oauth_consumer, access_token, access_secret)
  end
  
  
end