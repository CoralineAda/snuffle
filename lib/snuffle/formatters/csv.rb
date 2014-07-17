module Snuffle
  module Formatters

    class Csv

      include Formatters::Base

      def header
        columns.join(',')
      end

      def rows
      #   summary.object_candidates.map do |candidate|
      #     [summary.path_to_file, summary.class_name, "##{candidate.join(" #")}"].join(',')
      #   end
        summary.cohorts.group_by{|c| c.values}.map do |cohort|
          [summary.path_to_file, summary.class_name, cohort[0].join("; "), cohort[1].map(&:line_numbers).join("; ")].join(',')
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