module Snuffle

  module Element

    class Hash

      attr_accessor :node

      def self.materialize(nodes=[])
        node.each.map{|hash_node| new(hash_node) }
      end

      def initialize
        self.node = node
      end

      def pairs
        @pairs ||= values.zip(keys).inject({}){|hash, pair| hash[pair[0]] = pair[1]; hash}
      end

      def keys
        node.children.map{ |child| child.first.name }
      end

      def values
        node.children.map{ |child| child.last.name }
      end

    end

  end

end