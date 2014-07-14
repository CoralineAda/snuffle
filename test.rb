require 'snuffle'

def hash_clump
  @hash_clump ||= Snuffle::CohortDetector.new(file_parser.hashes)
end

def string_clump
  @string_clump ||= Snuffle::CohortDetector.new(file_parser.strings)
end

def source_file
  @source_file ||= Snuffle::SourceFile.new(path_to_file: "spec/fixtures/program_2.rb")
end
