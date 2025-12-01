class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @search_form = TaskSearchForm.new(search_params)
    @tasks = @search_form.search
  end

  def show; end

  def new
    @task = Task.new
  end

  def edit; end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = "タスクが作成されました"
      redirect_to tasks_path, status: :see_other
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @task.update(task_params)
      flash[:notice] = "タスクが更新されました"
      redirect_to tasks_path, status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @task.destroy
    flash[:success] = "タスクが削除されました"
    redirect_to tasks_path, status: :see_other
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :status)
  end

  # FormObject で使う値だけを許可params
  def search_params
    params.fetch(:task_search_form, {}).permit(:title, :status, :order)
    #  requireではなくfetch　ask_search_form があればその中身（ハッシュ）を返す。なければ {}（空ハッシュ）を返す → エラーにならない！
  end
end
