module Fictium
  class ApiBlueprintExporter
    class BaseFormatter
      def format(subject)
        sections = format_sections(subject)
        join_sections(sections)
      end

      protected

      def join_sections(sections)
        sections.each(&:strip).select(&:present?).join("\n\n")
      end
    end
  end
end
