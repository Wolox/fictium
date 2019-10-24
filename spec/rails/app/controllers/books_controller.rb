class BooksController < ApplicationController
  def index
    render json: topic.books
  end

  private

  def topic
    Topic[params.require(:topic_id)]
  end
end
