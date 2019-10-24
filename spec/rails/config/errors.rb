module Fictium
  Error = Class.new(StandardError)
  RecordNotFound = Class.new(Error)
  Unauthorized = Class.new(Error)
end
