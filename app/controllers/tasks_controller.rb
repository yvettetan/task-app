class TasksController < ApplicationController
  before_action :set_category
  before_action :set_task, only: %i[show]
  def index
    @tasks = @category.tasks
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

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_task
    @task = @category.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description)
  end
end
