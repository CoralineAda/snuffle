module Snuffle

  module Element

    class Hash

      attr_accessor :node

      def self.materialize(nodes=[])
        nodes.each.map{|hash_node| new(hash_node) }.select{|h| h.pairs.present?}
      end

      def self.overlapping(hashes=[])
        {
          keys:   Snuffle::Histogram.from(hashes.map(&:keys)).select{|k,v| v > 1},
          values: Snuffle::Histogram.from(hashes.map(&:values)).select{|k,v| v > 1}
        }
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

    end

  end

end