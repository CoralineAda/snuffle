module Snuffle

  class Summary

    include PoroPlus

    attr_accessor :class_name, :file, :object_candidates

    def to_a
      [self.class_name, self.file, self.object_candidates]
    end

  end

end