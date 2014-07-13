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
        summary.object_candidates.map do |candidate|
          [summary.path_to_file, summary.class_name, "##{candidate.join(", #")}"]
        end
      end

    end

  end
end