class LinksController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :fetch_link, only: %i[index show update destroy]
  before_action :authorize!, only: %i[update destroy]

  def index
    @link.increment_view! # TODO: make it async in batches

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

  def update
    if @link.update(link_params)
      render json: LinkSerializer.new(@link), status: :created
    else
      render json: ErrorSerializer.new(@link), status: :unprocessable_entity
    end
  end

  def destroy
    @link.destroy!

    head :ok
  end

  private

  def fetch_link
    @link = Link.find_by!(slug: params[:slug])
  end

  def link_params
    params.permit(:original_url, :password)
  end

  def authorize!
    head :unauthorized unless @link.authenticate(params[:password])
  end
end
