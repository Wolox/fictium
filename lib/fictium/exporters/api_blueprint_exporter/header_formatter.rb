module Fictium
  class ApiBlueprintExporter
    class HeaderFormatter
      delegate :title, :description, to: :info

      def format(_document)
        <<~HEREDOC
          Format: 1A
          Host: #{host}

          # #{title}

          #{description}
        HEREDOC
      end

      private

      def info
        Fictium.configuration.info
      end

      def host
        Fictium.configuration.api_blueprint.host
      end
    end
  end
end
