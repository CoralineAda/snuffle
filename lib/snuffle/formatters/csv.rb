module Formatters

  class Csv

    include Formatters::Base

    def header
      columns.join(',')
    end

    def rows
      file.object_candidates.map do |candidate|
        "#{file.class_name},##{candidate.join(" #")}"
      end.join("\r\n")
    end

    def footer
    end

    def file_extension
      ".csv"
    end

  end

end