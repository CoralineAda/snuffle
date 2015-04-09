module Snuffle

  module Formatters

    module Base

      def self.included(klass)
        klass.send(:attr_accessor, :summary)
        klass.send(:attr_accessor, :source)
      end

      def initialize(summary, source="")
        self.summary = summary
        self.source = source
      end

      def content
        [header, rows, footer].flatten.join("\r\n")
      end

      def columns
        ["filename", "host class", "candidate object attributes", "source line numbers"]
      end

      def root_path
        "doc/snuffle"
      end

      def output_path
        return @output_path if @output_path
        path = root_path
        path << "/" + summary.path_to_results if summary
        FileUtils.mkpath(path)
        @output_path = path
      end

      def path_to_results
        "#{output_path}/#{filename}"
      end

      def filename
        "#{summary.filename}" + file_extension
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