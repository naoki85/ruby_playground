class ApplicationController < ActionController::Base
  before_action :check_host_name

  concerning :CommonExceptionHandling do
    class Forbidden < ActionController::ActionControllerError; end
    class Locked < ActionController::ActionControllerError; end
    class InvalidParameter < ActionController::ActionControllerError; end
    class ServiceUnavailable < ActionController::ActionControllerError; end

    included do
      rescue_from Exception,                      with: :render_500
      rescue_from InvalidParameter,               with: :render_400
      rescue_from ActiveRecord::RecordNotFound,   with: :render_404
      rescue_from ActionController::RoutingError, with: :render_404
      rescue_from ActionView::MissingTemplate,    with: :render_404
    end

    def render_500(e = nil)
      if e
        logger.error "Rendering 500 with exception: #{e.message}"
        logger.error e.backtrace[0].to_s if e.backtrace.present? && !e.backtrace.empty?
      end

      if request.xhr?
        render json: { error: '500 errors' }, status: :internal_server_error
      else
        respond_to do |format|
          format.html do
            render template: 'errors/error_500', status: :internal_server_error, layout: 'application', content_type: 'text/html'
          end
          format.json do
            @return_code = 500
            render 'v1/errors/error', status: :internal_server_error
          end
          format.all do
            render text: 'Not Acceptable', status: :not_acceptable
          end
        end
      end
    end

    def render_400(e = nil)
      if e
        logger.error "Rendering 400 with exception: #{e.message}"
        logger.error e.backtrace[0].to_s if e.backtrace.present? && !e.backtrace.empty?
      end

      if request.xhr?
        render json: { error: '400 errors' }, status: :bad_request
      else
        respond_to do |format|
          format.html do
            render template: 'errors/error_400', status: :bad_request, layout: 'application', content_type: 'text/html'
          end
          format.json do
            @return_code = 400
            render 'v1/errors/error', status: :bad_request
          end
          format.all do
            render text: 'Not Acceptable', status: :not_acceptable
          end
        end
      end
    end

    def render_401(e = nil)
      if e
        logger.error "Rendering 401 with exception: #{e.message}"
        logger.error e.backtrace[0].to_s if e.backtrace.present? && !e.backtrace.empty?
      end

      if request.xhr?
        render json: { error: '401 errors' }, status: :unauthorized
      else
        respond_to do |format|
          format.html do
            render template: 'errors/error_401', status: :unauthorized, layout: 'application', content_type: 'text/html'
          end
          format.json do
            @return_code = 401
            render 'v1/errors/error', status: :unauthorized
          end
          format.all do
            render text: 'Not Acceptable', status: :not_acceptable
          end
        end
      end
    end

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
            render 'v1/errors/error', status: :not_found
          end
          format.all do
            render text: 'Not Acceptable', status: :not_acceptable
          end
        end
      end
    end
  end

  def check_host_name
    if Rails.env.production? && request.host == 'naoki85.me'
      render template: 'errors/error_404', status: 404, layout: false, content_type: 'text/html'
    end
  end
end
