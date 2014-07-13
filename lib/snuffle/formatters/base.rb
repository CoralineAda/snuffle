module Snuffle

  module Formatters

    module Base

      def self.included(klass)
        klass.send(:attr_accessor, :summary)
      end

      def initialize(summary)
        self.summary = summary
      end

      def content
        [header, rows, footer].flatten.join("\r\n")
      end

      def columns
        ["filename", "host class", "candidate object attributes"]
      end

      def root_path
        "doc/snuffle"
      end

      def output_path
        FileUtils.mkpath(root_path)
        root_path
      end

      def path_to_results
        "#{output_path}/#{filename}"
      end

      def filename
        base = summary.class_name.downcase.gsub(/[^a-zA-Z0-9]/, '_')
        base + file_extension
      end

      def file_extension
        ""
      end

      def export
        outfile = File.open("#{path_to_results}", 'w')
        outfile.write(content)
        outfile.close
        path_to_results
      end

    end

  end
end