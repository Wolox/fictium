module Fictium
  class Model
    def postman
      @postman ||= PostmanMetadata.new
    end
  end
end
