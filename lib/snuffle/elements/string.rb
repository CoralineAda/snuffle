module Snuffle

  module Element

    class String

      attr_accessor :node

      def self.materialize(nodes=[])
        nodes.each.map{|string_node| new(string_node) }
      end

      def initialize(node)
        self.node = node
      end

      def values
        node.children.map{ |child| child.children.last.name }.select{|v| v.is_a?(Symbol)}
      end

      def matrix
        values.sort.map(&:hash)
      end

      def inspect
        values
      end

    end

  end

end