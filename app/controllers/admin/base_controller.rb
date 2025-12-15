module Admin
  class BaseController < ApplicationController
    before_action :require_admin
    rescue_from ::ForbiddenError, with: :render_forbidden

    private

    def require_admin
      raise ::ForbiddenError unless current_user&.admin?
    end

    def render_forbidden
      render 'errors/forbidden', status: :forbidden
    end
  end
end
