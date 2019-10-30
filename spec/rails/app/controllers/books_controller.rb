class BooksController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    response.set_header('X-Using-Pagination', 'NO')
    render json: topic.books
  end

  private

  def topic
    Topic[params.require(:topic_id)]
  end
end
