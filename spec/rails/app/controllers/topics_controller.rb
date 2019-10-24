class TopicsController < ApplicationController
  def index
    render json: Topic.all
  end

  def show
    render json: topic
  end

  private

  def topic
    Topic[params.require(:id)]
  end
end
