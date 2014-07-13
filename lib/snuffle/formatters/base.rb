module Formatters

  module Base

    def self.included(klass)
      klass.send(:attr_accessor, :file)
    end

    def initialize(file)
      self.file = file
    end

    def content
      [header, rows, footer].flatten.join("\r\n")
    end

    def columns
      ["originating class", "candidate object attributes"]
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
      base = self.file.class_name.downcase.gsub(/[^a-zA-Z0-9]/, '_')
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
