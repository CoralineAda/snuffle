require 'parser/current'
require 'rubytree'
require 'pry'

module Snuffle
  module Detectors
    class DataClump

      attr_accessor :content

      def initialize(content=nil)
        self.content = content || File.read("./spec/fixtures/program_1.rb")
      end

      def parsed_content
        @parsed_content ||= Parser::CurrentRuby.parse(self.content)
      end

      # def build_tree
      #   tree = Tree::TreeNode.new("ROOT", "Root Content")
      #   extract_nodes(parsed_content).each do |pair|
      #     tree << Tree::TreeNode.new(pair)
      #   end
      #   tree
      # end

      def extract_nodes(node, nodes=[])
        if node.respond_to?(:type)
          nodes << node.type
        end
        if node.respond_to?(:children)
          nodes << node.children.map{|child| extract_nodes(child, nodes)}.flatten
        end
        nodes
      end

      def hashes
        extract_nodes(parsed_content).select{|node| node.respond_to?(:type) && node.type == :hash}
      end

    end
  end
end