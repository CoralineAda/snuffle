module Snuffle

  module Element

    class Hash

      attr_accessor :node

      def self.materialize(nodes=[])
        nodes.each.map{|hash_node| new(hash_node) }.select{|h| h.pairs.present?}
      end

      def initialize(node)
        self.node = node
      end

      def pairs
        @pairs ||= values.zip(keys).inject({}){|hash, pair| hash[pair[0]] = pair[1]; hash}
      end

      def keys
        node.children.map{ |child| child.children.first && child.children.first.name }
      end

      def values
        node.children.map{ |child| child.children.last && child.children.last.name }
      end

      def matrix
        keys.map(&:to_s).sort.map(&:hash)
      end

      def sorted_pairs
        keys.map(&:to_s).sort.inject({}) { |h, k| h[k] = pairs[k]; h}
      end

      def inspect
        sorted_pairs
      end

    end

  end

end