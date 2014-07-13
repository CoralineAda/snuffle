module Formatters

  class Csv

    include Formatters::Base

    def header
      columns.join(',')
    end

    def rows
      file.object_candidates.map do |method|
        "#{file.path_to_file},#{method.prefix}#{method.name},#{method.complexity}"
      end.join("\r\n")
    end

    def footer
    end

    def file_extension
      ".csv"
    end

  end

end