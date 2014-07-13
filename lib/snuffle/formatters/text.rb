require 'text-table'

module Formatters

  class Text

    include Formatters::Base

    def header
      ["Class", "Object Candidates"]
    end

    def export
      table = ::Text::Table.new
      table.head = header
      table.rows = rows
      table.to_s
    end

    def rows
      file.object_candidates.map do |candidate|
        [file.class_name, candidate.join(", ")]
      end
    end

    def footer
    end

  end

end
