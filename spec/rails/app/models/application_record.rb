class ApplicationRecord
  include ActiveModel::Model

  attr_accessor :id

  class << self
    include Enumerable

    delegate :each, :first, :last, to: :all

    def all; end

    def find(id)
      value = all.find { |record| record.id == id.to_i }
      raise Fictium::RecordNotFound if value.blank?

      value
    end

    def [](id)
      find(id)
    end
  end

  def ==(other)
    other.class == self.class && other.id == id
  end
end
