module CategoriesHelper

  def completed_tasks(category) 
    category.tasks.where(completed: true).count  
  end

end
