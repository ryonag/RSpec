class MyCommentsController < ApplicationController
  before_action :set_my_thread
  before_action :set_my_comment, only: [:show, :edit, :update, :destroy]
  # GET /my_comments
  # GET /my_comments.json
  def index
    @my_comments = @my_thread.my_comments
  end

  def new
    @my_comment = @my_thread.my_comments.new
  end

  def edit
  end

  def create

    @my_comment = @my_thread.my_comments.new(my_comment_params)

    respond_to do |format|
      if @my_comment.save
        format.html { redirect_to my_thread_my_comments_url(@my_thread), notice: 'My comment was successfully created.' }
        format.json { render :show, status: :created, location: @my_comment } #status以降はハッシュ
      else
        format.html { render :new } #defnewをさしている。
        format.json { render json: @my_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @my_comment.update(my_comment_params)
        format.html { redirect_to my_thread_my_comments_url(@my_thread), notice: 'My comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @my_comment }
      else
        format.html { render :edit }
        format.json { render json: @my_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @my_comment.destroy
    respond_to do |format|
      format.html { redirect_to my_thread_my_comments_url(@my_thread), notice: 'My comment was successfully destroyed.' }
    end
  end

  private
  def set_my_comment
      @my_comment = @my_thread.my_comments.find(params[:id])
  end

  def my_comment_params
      params.require(:my_comment).permit(:content)
  end

  def set_my_thread
      @my_thread = MyThread.find params[:my_thread_id]#モデルを経由してデータベースに入る。:はシンボル。
  end

end
