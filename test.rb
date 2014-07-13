require 'snuffle'

def file_parser
  @file_parser ||= Snuffle::FileParser.new(File.open("spec/fixtures/program_2.rb", "r").read)
end

def hash_clump
  @hash_clump ||= Snuffle::CohortDetector.new(file_parser.hashes)
end

def string_clump
  @string_clump ||= Snuffle::CohortDetector.new(file_parser.strings)
end