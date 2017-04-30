class TasksController < ProtectedController
  def index
    @tasks = current_user.lists.find(params[:list_id]).tasks

    render json: @tasks
  end

  def create
    @task = current_user.lists.find(params[:list_id]).tasks.build(task_params)

    if @task.save
      render json: @task
    else
      render json: @task.errors.to_a, status: :unprocessable_entity
    end
  end

  # list
  # 1 - T1, T2, T3
  # 2 - T1, T2, T3
  #
  #
  # 1 ,2 - current_user.lists.find(params[:list_id]) - Query 1
  #
  # 1
  #
  # 1T1, 1T2, 1T3, - current_user.lists.find(params[:list_id]).tasks
  #
  # 1T3 - current_user.lists.find(params[:list_id]).tasks.find(params[:id]) - Query 2

  # 1T1
  # 1T2
  # 1T3
  # 2T1
  # 2T2
  # 2T3
  #
  # Join 2 tables
  #
  # Table 1, field from table 1 which is present in table 2
  #
  # List id is present in task
  # Join List and task
  #
  # join task on task.list_id = list.


  def update
    @task = List.joins(:tasks).where(tasks: {id: params[:id]}, lists: {user_id: current_user.id})

    if @task.update_attributes(task_params)
      render json: @task
    else
      render json: @task.errors.to_a, status: :unprocessable_entity
    end
  end

  def destroy
    @task = Task.joins(:list).where(lists: {user_id: current_user.id, id: params[:list_id]}).find_by(tasks: {id: params[:id]})

    if @task.destroy
      render json: {id: @task.id}
    else
      render json: {id: @task.id}, status: :unprocessable_entity
    end
  end

  private

    def task_params
      params.require(:task).permit(:name, :completed)
    end
end
