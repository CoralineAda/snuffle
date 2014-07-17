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

      def preprocessed
        formatter.format(lexer.lex(source))
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