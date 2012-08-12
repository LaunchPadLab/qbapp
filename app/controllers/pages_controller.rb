class PagesController < ApplicationController
  
  def home
    @title = "QB | Home"
  end
  
  def dashboard
    @title = "QB | Dashboard"
    user = User.find(session[:user_id])
    
    qb_oauth_consumer = OAuth::Consumer.new(QB_KEY, QB_SECRET, {
        :site                 => "https://oauth.intuit.com",
        :request_token_path   => "/oauth/v1/get_request_token",
        :authorize_url        => "https://appcenter.intuit.com/Connect/Begin",
        :access_token_path    => "/oauth/v1/get_access_token"
    })
    oauth_client = OAuth::AccessToken.new(qb_oauth_consumer, user.access_token, user.access_secret)
    customer_service = Quickeebooks::Online::Service::Customer.new
    customer_service.access_token = oauth_client
    customer_service.realm_id = user.realmID
    @collection = customer_service.list
    
    account_service = Quickeebooks::Online::Service::Account.new
    account_service.access_token = oauth_client
    account_service.realm_id = user.realmID
    @collection_account = account_service.list
    
    company_service = Quickeebooks::Online::Service::CompanyMetaData.new
    company_service.access_token = oauth_client
    company_service.realm_id = user.realmID
    @collection_company = company_service.load
    
    @income = 0
    @expenses = 0
    
    @collection_account.entries.each do |account|
      if account.current_balance.present?
        if account.sub_type.downcase.index('cost')
          @expenses += account.current_balance
        elsif account.sub_type.downcase.index('income')
          @income += account.current_balance
        end
      end
    end 
    
    # #"https://qbo.intuit.com/qbo36"
    # @xml = Nokogiri::XML(oauth_client.post("https://qbo.intuit.com/qbo36/resource/customers/v2/#{user.realmID}").body)
    # @collection = Quickeebooks::Collection.new
    # @results = []
    # @collection.count = @xml.xpath("//qbo:SearchResults/qbo:Count")[0].text.to_i
    # 
    # if @collection.count > 0
    #   @xml.xpath("//qbo:SearchResults/qbo:CdmCollections/xmlns:#{Quickeebooks::Online::Model::Customer::XML_NODE}").each do |xa|
    #     @results << Quickeebooks::Online::Model::Customer.from_xml(xa)
    #   end
    # end
    # @collection.entries = @results
    # @collection.current_page = @xml.xpath("//qbo:SearchResults/qbo:CurrentPage")[0].text.to_i    

  end
    
end