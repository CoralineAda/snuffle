require 'text-table'

module Snuffle
  module Formatters

    class Text

      include Formatters::Base

      def header
        columns.map(&:titleize)
      end

      def export
        table = ::Text::Table.new
        table.head = header
        table.rows = rows
        table.to_s
      end

      def rows
        summary.cohorts.group_by{|c| c.values}.map do |cohort|
          [summary.path_to_file, summary.class_name, "#{cohort[0].join(', ')}", cohort[1].map(&:line_numbers).join(", ")]
        end
      end

    end

  end
end