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
        @pairs ||= keys.zip(values).inject({}){|hash, pair| hash[pair[0]] = pair[1]; hash}
      end

      def keys
        node.children.map{ |child| child.children.first && child.children.first.name }
      end

      def values
        node.children.map{ |child| child.children.last && child.children.last.name }.map(&:to_s).sort
      end

      def inspect
        pairs
      end

    end

  end

end