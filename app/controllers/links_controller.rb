class LinksController < ApplicationController
  def create
    @link = Link.create(link_params)
  end

  private

  def link_params
    params.permit(:original_url, :password)
  end
end
