class Book < ApplicationRecord
  attr_accessor :name, :topics
  class << self
    BOOKS = [
      Book.new(
        id: 1,  name: 'A', topics: [Topic[1]]
      ).freeze,
      Book.new(
        id: 2,  name: 'B', topics: [Topic[2]]
      ).freeze,
      Book.new(
        id: 3,  name: 'C', topics: [Topic[3]]
      ).freeze,
      Book.new(
        id: 4,  name: 'D', topics: [Topic[1]]
      ).freeze,
      Book.new(
        id: 5,  name: 'E', topics: [Topic[2]]
      ).freeze,
      Book.new(
        id: 6,  name: 'F', topics: [Topic[3], Topic[2]]
      ).freeze,
      Book.new(
        id: 7,  name: 'G', topics: [Topic[1], Topic[3]]
      ).freeze,
      Book.new(
        id: 8,  name: 'H', topics: [Topic[2], Topic[1]]
      ).freeze,
      Book.new(
        id: 9,  name: 'I', topics: [Topic[3], Topic[2]]
      ).freeze,
      Book.new(
        id: 10, name: 'J', topics: [Topic[1], Topic[3]]
      ).freeze
    ].freeze

    def all
      BOOKS
    end
  end
end
