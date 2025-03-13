Rails.application.configure do
  config.exceptions_app = ErrorsController.action(:render_404)
end