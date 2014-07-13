require 'rouge'

module Snuffle
  module Formatters

    class Html

      include Formatters::Base

      def formatter
        Rouge::Formatters::HTML.new(css_class: 'highlight', line_numbers: true)
      end

      def lexer
        lexer = Rouge::Lexers::Ruby.new
      end

      def preprocessed
        preprocessed = formatter.format(lexer.lex(summary.source))
        summary.object_candidates.flatten.uniq.each do |keyword|
          begin
            preprocessed.gsub!(/\b#{keyword}\b/, "<span class='highlighted'>#{keyword.gsub(/[^a-zA-Z0-9\_]/,'')}</span>")
          rescue
            preprocessed
          end
        end
        preprocessed
      end

      def content
        Haml::Engine.new(output_template).render(
          Object.new, {
            summary: summary,
            source_lines: preprocessed,
            date: Time.now.strftime("%Y/%m/%d"),
            time: Time.now.strftime("%l:%M %P")
          }
        )
      end

      def output_template
        File.read(File.dirname(__FILE__) + "/templates/output.html.haml")
      end

      def root_path
        "doc/snuffle/source"
      end

      def file_extension
        ".htm"
      end

    end

  end
end