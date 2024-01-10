class LinksController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :fetch_link, only: %i[index show]

  def index
    @link.increment_view!

    redirect_to @link.original_url, allow_other_host: true
  end

  def show
    render json: LinkSerializer.new(@link), status: :ok
  end

  def create
    link = Link.new(link_params)

    if link.save
      render json: LinkSerializer.new(link), status: :created
    else
      render json: ErrorSerializer.new(link), status: :unprocessable_entity
    end
  end

  private

  def fetch_link
    @link = Link.find_by!(slug: params[:slug])
  end

  def link_params
    params.permit(:original_url, :password)
  end
end
