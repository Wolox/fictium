class Topic < ApplicationRecord
  attr_accessor :name

  class << self
    TOPICS = [
      Topic.new(id: 1, name: 'Fables').freeze,
      Topic.new(id: 2, name: 'Horror').freeze,
      Topic.new(id: 3, name: 'Comedy').freeze
    ].freeze

    def all
      TOPICS
    end
  end

  def books
    Book.select { |book| book.topics.include?(self) }
  end
end
