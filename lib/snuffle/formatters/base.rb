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
      ["file", "object candidates"]
    end

    def root_path
      "doc/snuffle"
    end

    def output_path
      output_path = "#{root_path}/#{self.file.path_to_file.split('/')[0..-2].join("/")}"
      FileUtils.mkpath(output_path)
      output_path
    end

    def path_to_results
      "#{output_path}/#{filename}"
    end

    def filename
      self.file.path_to_file.split('/')[-1] + file_extension
    end

    def file_extension
      ""
    end

    def export
      begin
        outfile = File.open("#{path_to_results}", 'w')
        outfile.write(content)
      rescue Exception => e
        puts "Unable to write output: #{e} #{e.backtrace}"
      ensure
        outfile && outfile.close
      end
    end

  end

end
