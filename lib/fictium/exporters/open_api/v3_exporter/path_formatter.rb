module Fictium
  module OpenApi
    class V3Exporter
      class PathFormatter
        def add_path(paths, action)
          paths[action.full_path]
        end
      end
    end
  end
end
