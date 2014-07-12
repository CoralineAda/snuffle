require 'snuffle'

def reload!
  load "lib/snuffle/node.rb"
  load "lib/snuffle/detectors/data_clump.rb"
end

def file
  File.open("spec/fixtures/program_2.rb", "r").read
end

def file_parser
  @file_parser ||= Snuffle::FileParser.new(file)
end

def hashes
  file_parser.hashes
end

def clump
  @clump ||= Snuffle::Detectors::HashClump.new(hashes)
end