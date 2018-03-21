class ErrorsController < ActionController::Base
  rescue_from ActionController::RoutingError, with: :render_404

  def render_404(e = nil)
    if e
      logger.error "Rendering 404 with exception: #{e.message}"
      logger.error "#{e.backtrace[0]}" if e.backtrace.present? and e.backtrace.length > 0
    end

    if request.xhr?
      render json: { error: '404 errors' }, status: 404
    else
      respond_to do |format|
        format.html {
          render template: 'errors/error_404', status: 404, layout: 'application', content_type: 'text/html'
        }
        format.json {
          @return_code = 404
          render 'api/errors/error', status: 404
        }
        format.all {
          render :text => 'Not Acceptable', status: 406
        }
      end
    end
  end
end
