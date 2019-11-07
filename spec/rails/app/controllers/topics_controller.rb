class TopicsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    render json: Topic.all
  end

  def show
    render json: topic
  end

  def create
    new_topic = Topic.new(topic_params)
    render json: new_topic, status: :created
  end

  def update
    topic
    topic_params
    render json: topic, status: :ok
  end

  def destroy
    topic
    render status: :no_content
  end

  private

  def topic
    Topic[params.require(:id)]
  end

  def topic_params
    params.require(:topic).permit(:name)
  end
end
