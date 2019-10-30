class BooksController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    response.set_header('X-Using-Pagination', 'NO')
    render json: topic.books
  end

  def promote
    render json: book
  end

  private

  def topic
    Topic[params.require(:topic_id)]
  end

  def book
    Book.find(params.require(:id))
  end
end
