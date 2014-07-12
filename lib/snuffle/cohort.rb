module Snuffle

  class Cohort

    include PoroPlus
    attr_accessor :element, :neighbors

    def neighbor
      Struct.new(:element, :distance)
    end

    def neighbor=(element, distance)
      @neighbors ||= []
      @neighbors << neighbor(element, distance)
      @neighbors
    end

  end

end