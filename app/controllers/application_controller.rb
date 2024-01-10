class ApplicationController < ActionController::Base
  rescue_from Mongoid::Errors::DocumentNotFound, with: :render_404

  private

  def render_404
    head :not_found
  end
end
