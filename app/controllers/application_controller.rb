class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate

  def authenticate
    session_cookie = cookies['_devise-api_session']
    puts session_cookie
    if cookies['_devise-api_session'].nil?
      response = RestClient.get APP_CONFIG.services.current_user
    else
      response = RestClient.get APP_CONFIG.services.current_user, :cookies => {'_devise-api_session' => session_cookie}
    end

    puts response
    parsed_response = JSON.parse(response)
    current_user = parsed_response['user']

    if current_user.nil?
      redirect_to users_sign_in_path
      return
    else
    end
  end


end
