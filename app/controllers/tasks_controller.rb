class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = Task.order(updated_at: :desc)
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
    params.require(:task).permit(:title, :content, :deadline)
  end
end
