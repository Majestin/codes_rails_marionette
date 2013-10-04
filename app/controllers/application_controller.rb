class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
  	gon.environment = Rails.env	
    
  	@all_snippets_count = Snippet.count
  	gon.watch.all_snippets_count = @all_snippets_count 

    @user = current_user || User.new
    @snippets_count = @user.snippets.count    
    gon.watch.snippets_count = @snippets_count 
  end

  before_filter :configure_permitted_parameters, if: :devise_controller?

  def authority_forbidden(error)
  	Authority.logger.warn(error.message)
  	redirect_to request.referrer.presence || root_path, :alert => 'You are not authorized to complete that action.'
  end


  protected

  def configure_permitted_parameters
  	devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :avatar) }
  	devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :avatar, :current_password) }
  end  
end
