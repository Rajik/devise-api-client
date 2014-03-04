class AuthenticationController < ApplicationController

  skip_before_filter :authenticate
  skip_before_filter :verify_authenticity_token

  def sign_in
    puts 'Sign In'
    response = RestClient.post(APP_CONFIG.services.sign_in, params[:user])
    puts '*********'
    puts response.cookies


    json_parse = JSON.parse(response)
    if response.code == 200
      cookies['_devise-api_session'] = response.cookies['_devise-api_session']
      redirect_to root_path
      return
    end
    rescue RestClient::Unauthorized
      flash[:error] = "Invalid username/password"
      @user = User.new
      render :new
  end

  def new
    @user = User.new
  end
end
