require 'coderay'

module Snuffle
  module Formatters

    class Html

      include Formatters::Base

      def content
        Haml::Engine.new(output_template).render(
          Object.new, {
            summary: summary,
            formatted_source: ::Coderay.scan(summary.source_file.source, :ruby).div(:line_numbers => :table),
            date: Time.now.strftime("%Y/%m/%d"),
            time: Time.now.strftime("%l:%M %P")
          }
        )
      end

      def output_template
        File.read(File.dirname(__FILE__) + "/templates/output.html.haml")
      end

    end

  end
end