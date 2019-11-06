module Fictium
  class ApiBlueprintExporter
    class BaseFormatter
      def format(subject)
        format_sections(subject).each(&:strip).select(&:present?).join("\n\n")
      end
    end
  end
end
