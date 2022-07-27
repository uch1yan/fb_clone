class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy ]
  before_action :authenticate_user, only: [:edit, :update, :destroy ]

  # GET /feeds or /feeds.json
  def index
    @feeds = Feed.all
  end

  # GET /feeds/1 or /feeds/1.json
  def show
  end

  # GET /feeds/new
  def new
    if params[:back]
      @feed = Feed.new(feed_params)
    else
      @feed = Feed.new
    end
  end

  # GET /feeds/1/edit
  def edit
  end

  # POST /feeds or /feeds.json
  def create
    @feed = current_user.feeds.build(feed_params)
    if params[:back]
      render :new
    elsif @feed.save
      redirect_to feeds_path, notice: '投稿しました！'
    else
      render :new
    end
  end
  #   respond_to do |format|
  #     if @feed.save
  #       format.html { redirect_to feed_url(@feed), notice: "Feed was successfully created." }
  #       format.json { render :show, status: :created, location: @feed }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @feed.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /feeds/1 or /feeds/1.json
  def update
    if @feed.update(feed_params)
      redirect_to feeds_path, notice: '投稿を更新しました！'
    else
      render :edit
    end
  end
  #   respond_to do |format|
  #     if @feed.update(feed_params)
  #       format.html { redirect_to feed_url(@feed), notice: "Feed was successfully updated." }
  #       format.json { render :show, status: :ok, location: @feed }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @feed.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def confirm
    @feed = current_user.feeds.build(feed_params)
    render :new if @feed.invalid?
  end
  # DELETE /feeds/1 or /feeds/1.json
  def destroy
    if @feed.destroy
      redirect_to feeds_path, notice: '投稿を削除しました！'
    else
      render :index
    end
  end
  #   respond_to do |format|
  #     format.html { redirect_to feeds_url, notice: "Feed was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feed
      @feed = Feed.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def feed_params
      params.require(:feed).permit(:image, :image_cache, :content)
    end
end
