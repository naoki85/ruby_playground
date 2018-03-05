class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  protected

  def update_resource(resource, params)
    if resource.from_social?
      resource.update_without_password(params) && resource.attach_image(params)
    else
      resource.update_with_password(params) && resource.attach_image(params)
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :image])
  end
end
