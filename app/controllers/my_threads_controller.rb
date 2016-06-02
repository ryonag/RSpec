class MyThreadsController < ApplicationController
  def index
    @my_threads = MyThread.all
  end
  def create

    @my_thread = MyThread.new(title: params[:my_thread][:title])#ハッシュ

    respond_to do |format|
      if @my_thread.save
        format.html { redirect_to my_threads_path, notice: 'My thread was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end
  def new
    @my_thread = MyThread.new
  end
  def edit
    @my_thread = MyThread.find(params[:id])
  end
  def show
      #@my_thread = MyThread.find(params[:id])
      #@my_comments = @my_thread.my_comments
    end
    def update
      @my_thread = MyThread.find(params[:id])
      if @my_thread.update(my_thread_params)
        redirect_to my_threads_path, notice: 'My thread was successfully updated.'#redirect_toはメソッド。第一引数のパスもメソッド。
      else
        render :edit
      end
    end
    def destroy
      @my_thread = MyThread.find(params[:id])
      @my_thread.destroy
      redirect_to my_threads_path, notice: 'My thread was successfully destroyed.'
    end

    private

    def my_thread_params
      # {my_thread : {title: 'value'}}
      params.require(:my_thread).permit(:title)
    end
  end
