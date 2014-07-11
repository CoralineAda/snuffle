require 'snuffle'

def reload!
  load "lib/snuffle/node.rb"
  load "lib/snuffle/detectors/data_clump.rb"
end

def file
  File.open("spec/fixtures/program_2.rb", "r").read
end

def d
  @d ||= Snuffle::FileParser.new(file)
end
