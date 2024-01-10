class Admin::LinksController < Admin::ApplicationController
  def index
    @links = Link.page(params[:page]).per(10)
    @links = @links.search(params[:search]) if params[:search]
  end

  def destroy
    @link = Link.find_by!(slug: params[:slug])

    if @link.destroy
      redirect_to admin_links_path, notice: 'The user has been deleted'
    else
      redirect_to :back, alert: @link.errors.full_messages.join(', ')
    end
  end
end
