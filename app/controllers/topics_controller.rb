class TopicsController < ApplicationController
  def index
    @topics = Topic.visible_to(current_user).paginate(page: params[:page], per_page: 10)
  end

  def new
    @topic = Topic.new
    authorize! :create, @topic, message: "You need to be an admin to do that."
  end

  def show
    @topic = Topic.find(params[:id])
    authorize! :read, @topic, message: "You need to be signed-in to do that."
    @posts = @topic.posts.includes(:user).includes(:comments).paginate(page: params[:page], per_page: 10)
  end

  def edit
    @topic = Topic.find(params[:id])
    authorize! :update, @topic, message: "You need to be an admin to do that."
  end

  def create
    @topic = Topic.new(topic_params)
    authorize! :create, @topic, message: "You need to be an admin to do this."
    if @topic.save
       redirect_to @topic, notice: "Topic was saved successfully."
    else 
      flash[:error] = "Error creating topic. Please try again."
      render :new
    end
  end

  def update
    @topic = Topic.find(params[:id])
    authorize! :update, @topic, message: "You need to own the topic to update it."
    if @topic.update_attributes(topic_params)
      redirect_to @topic, notice: "Topic was saved successfully."
    else
      flash[:error] = "Error saving topic. Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    name = @topic.name
    authorize! :destroy, @topic, message: "You need to own the topic to delete it."
    if @topic.destroy
      redirect_to topics_path, notice: "\"#{name}\" was deleted successfully."
    else 
      flash[:error] = "Error deleting topic. Please try again."
      render :show
    end
  end

  def topic_params
      params.require(:topic).permit(:name, :description)
    end
end
