class TasksController < ApplicationController
    before_action :require_user_logged_in
    
    def index
        if logged_in?
          @tasks = current_user.tasks
        end
    end
    
    def show
        @task = Task.find(params[:id])
    end
    
    def new
        @task = Task.new
    end
    
    def create
        @task = current_user.tasks.build(task_params)
        
        if @task.save
            flash[:success] = 'タスクが正常に登録されました'
            redirect_to @task
        else
            flash.now[:danger] = 'タスクが登録されませんでした'
            render :new
        end
    end
    
    def edit
        @task = Task.find(params[:id])
    end
    
    def update
        @task = Task.find(params[:id])
        
        if @task.update(task_params)
            flash[:success] = 'タスクは正常に更新されました'
            redirect_to @task
        else
            flash.now[:danger] = 'タスクが更新されませんでした'
            render :edit
        end
    end
    
    def destroy
        @task = Task.find(params[:id])
        @task.destroy
        
        flash[:success] = 'タスクが削除されました'
        redirect_to tasks_url
    end
    
    private
    
    def task_params
        params.require(:task).permit(:status, :content, :user)
    end

end
