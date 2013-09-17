class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
  	gon.environment = Rails.env	
	@snippets_count = Snippet.count
	gon.watch.snippets_count = @snippets_count 
  end

  
end
