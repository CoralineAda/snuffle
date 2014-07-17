module Snuffle

  class Summary
    include PoroPlus
    attr_accessor :class_name, :path_to_file, :object_candidates, :source

    def class_filename
      self.class_name.downcase.gsub(' ', '_')
    end

  end

end