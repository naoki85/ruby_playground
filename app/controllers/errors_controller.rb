class ErrorsController < ActionController::Base
  rescue_from ActionController::RoutingError, with: :render_404

  def render_404(e = nil)
    if e
      logger.error "Rendering 404 with exception: #{e.message}"
      logger.error e.backtrace[0].to_s if e.backtrace.present? && !e.backtrace.empty?
    end

    if request.xhr?
      render json: { error: '404 errors' }, status: :not_found
    else
      respond_to do |format|
        format.html do
          render template: 'errors/error_404', status: :not_found, layout: 'application', content_type: 'text/html'
        end
        format.json do
          @return_code = 404
          render 'api/errors/error', status: :not_found
        end
        format.all do
          render text: 'Not Acceptable', status: :not_acceptable
        end
      end
    end
  end
end
