class Backend::ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, flash: { :warning => exception.message }
  end

  layout "application"

end
