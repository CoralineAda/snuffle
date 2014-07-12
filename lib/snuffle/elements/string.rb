module Snuffle

  module Element

    class String

      attr_accessor :node

      def self.materialize(nodes=[])
        nodes.each.map{|string_node| new(string_node) }.select{|h| h.pairs.present?}
      end

      def initialize(node)
        self.node = node
      end

      def pairs
        @pairs ||= values.zip(keys).inject({}){|hash, pair| hash[pair[0]] = pair[1]; hash}
      end

      def keys
        node.children.map{ |child| child.children.first.name }
      end

      def values
        node.children.map{ |child| child.children.last.name }
      end

      def key_matrix
        keys.sort.map(&:hash)
      end

      def value_matrix
        values.sort.map(&:hash)
      end

      def sorted_pairs
        keys.sort.inject({}) { |h, k| h[k] = pairs[k]; h}
      end

      def inspect
        sorted_pairs
      end

    end

  end

end