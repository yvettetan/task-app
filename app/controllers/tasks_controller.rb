class TasksController < ApplicationController
  before_action :set_category, except: %i[index]
  before_action :set_task, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def new
    @task = @category.tasks.build
  end

  def create
    @task = @category.tasks.build(task_params)
    if @category.save
      redirect_to @task.category
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to @task.category
    else
      render action: "edit"
    end
  end

  def destroy
    @task.destroy
    redirect_to @task.category, notice: "Task was successfully deleted."
  end

  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    redirect_to tasks_path, notice: "404 not found" if @task.nil?
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_task
    @task = @category.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :due_at, :user_id)
  end
end
