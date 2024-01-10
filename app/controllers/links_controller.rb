class LinksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    link = Link.new(link_params)

    if link.save
      render json: LinkSerializer.new(link), status: :created
    else
      render json: ErrorSerializer.new(link), status: :unprocessable_entity
    end
  end

  private

  def link_params
    params.permit(:original_url, :password)
  end
end
