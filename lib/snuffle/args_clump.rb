module Snuffle

  class Cohort

    include PoroPlus
    attr_accessor :element, :neighbors, :line_numbers

    def self.from(nodes)
      nodes = nodes.non_sends.hashes
      clumps = Element::Hash.materialize(nodes.to_a).inject([]) do |cohorts, element|
        clump = ArgsClump.new(args: element.args, line_numbers: element.node.line_numbers )
        if clump.values.count > 1 && clump.near_neighbors.count > 0
          clumps << clump
        end
        clumps
      end
    end

    def has_near_neighbors?
      near_neighbors.present?
    end

    def near_neighbors
      @near_neighbors ||= neighbors.select{ |n| (n.args & args).size == args.size }
    end

    def neighbors
      @neighbors ||= [element.node.siblings - [self.element.node]].flatten.map{|sibling| Element::Hash.materialize([sibling]).first}
    end

    def args
      @args ||= self.element.args
    end

    def neighbor
      Struct.new(:element, :distance)
    end

    def distance(primary_matrix, token_matrix)
      Snuffle::Util::Correlation.distance(primary_matrix, token_matrix)
    end

  end

end