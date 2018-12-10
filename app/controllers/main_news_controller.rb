class MainNewsController < ApplicationController
  before_action :set_main_news, only: [:show, :edit, :update, :destroy]

  # GET /main_news
  # GET /main_news.json
  def index
    @main_news = MainNews.all
  end

  # GET /main_news/1
  # GET /main_news/1.json
  def show
  end

  # GET /main_news/new
  def new
    @main_news = MainNews.new
  end

  # GET /main_news/1/edit
  def edit
  end

  # POST /main_news
  # POST /main_news.json
  def create
    @main_news = MainNews.new(main_news_params)

    respond_to do |format|
      if @main_news.save
        format.html { redirect_to @main_news, notice: 'Main news was successfully created.' }
        format.json { render :show, status: :created, location: @main_news }
      else
        format.html { render :new }
        format.json { render json: @main_news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /main_news/1
  # PATCH/PUT /main_news/1.json
  def update
    respond_to do |format|
      if @main_news.update(main_news_params)
        format.html { redirect_to @main_news, notice: 'Main news was successfully updated.' }
        format.json { render :show, status: :ok, location: @main_news }
      else
        format.html { render :edit }
        format.json { render json: @main_news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /main_news/1
  # DELETE /main_news/1.json
  def destroy
    @main_news.destroy
    respond_to do |format|
      format.html { redirect_to main_news_index_url, notice: 'Main news was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_main_news
      @main_news = MainNews.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def main_news_params
      params.require(:main_news).permit(:title, :description)
    end
end
