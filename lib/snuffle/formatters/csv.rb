module Snuffle
  module Formatters

    class Csv

      include Formatters::Base

      def header
        columns.join(',')
      end

      def rows
        summary.object_candidates.map do |candidate|
          [summary.path_to_file, summary.class_name, "##{candidate.join(" #")}"].join(',')
        end
      end

      def footer
      end

      def file_extension
        ".csv"
      end

    end

  end
end