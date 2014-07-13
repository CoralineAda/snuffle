module Snuffle
  class SourceParser

    attr_accessor :source_files, :reports

    def initialize(files=[])
      @source_files = [files].flatten.map{ |file| Snuffle::SourceFile.new(path_to_file: file) }
    end

    def cohorts_from(source_file)
      CohortDetector.new(source_file.nodes).cohorts
    end

    def report
      @reports ||= source_files.map do |source_file|
        {
          source_file: source_file.path_to_file,
          object_candidates: cohorts_from(source_file).map(&:values)
        }
      end
    end

  end
end