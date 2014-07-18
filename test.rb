require 'snuffle'

def source_file
  @source_file ||= Snuffle::SourceFile.new(path_to_file: "spec/fixtures/latent_object_fixture.rb")
end
