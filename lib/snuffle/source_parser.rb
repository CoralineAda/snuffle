require 'parser/current'

module Snuffle
  class SourceParser

    attr_accessor :source_files, :reports

    def initialize(source_files=[])
      @source_files = [source_files].flatten
    end

    def cohorts_from(source_file)
      CohortDetector.new(nodes: source_file.nodes).cohorts
    end

    def reports
      @reports ||= source_files.map do |source_file|
        Analysis.new(
          source_file: source_file,
          cohorts:     cohorts_from(source_file)
        )
      end
    end

  end
end