class MainNewsController < ApplicationController
  load_and_authorize_resource
  before_action :set_main_news, only: %i[show edit update destroy]

  def index
    @main_news = MainNews
      .all
      .includes(:user)
      .order(created_at: :desc)
  end

  def show
  end

  def new
    @main_news = current_user.main_news.build
  end

  def edit
  end

  def create
    @main_news = current_user.main_news.build(main_news_params)
    if @main_news.save
      redirect_to main_news_index_path, success: 'Main new successfully created'
    else
      render 'new', danger: 'News is not valid'
    end
  end

  def update 
		if @main_news.update_attributes(main_news_params)
			redirect_to @main_news, success: 'News successfully updated'
		else
			render 'edit', danger: 'It is not correct'
		end
  end
  
  def show
  end

  def destroy
    @main_news.destroy
  end

  private
    def set_main_news
      @main_news = MainNews.find(params[:id])
    end

    def main_news_params
      params.require(:main_news).permit(:title, :description, :user_id)
    end
end
