require 'parser/current'
require 'pry'

module Snuffle
  module Detectors
    class DataClump

      attr_accessor :content

      def initialize(content=nil)
        self.content = content || File.read("./spec/fixtures/program_1.rb")
      end

      def ast
        @ast ||= Parser::CurrentRuby.parse(self.content)
      end

      def nodes
        @nodes ||= extract_nodes_from(ast)
      end

      def extract_nodes_from(ast_node, nodes=Ephemeral::Collection.new("Node"), parent_id=:root)
        if ast_node.respond_to?(:type)
          extracted_node = Node.new(
            type: ast_node.type,
            parent_id: parent_id,
            name: name_from(ast_node)
          )
        else
#          extracted_node = Node.nil
           extracted_node = Node.new(
            type: :nil,
            parent_id: parent_id,
            name: name_from(ast_node)
          )
        end
        nodes << extracted_node
        ast_node.children.each{|child| extract_nodes_from(child, nodes, extracted_node.id)} if ast_node.respond_to?(:children)
        nodes
      end

      def name_from(node)
        return "unknown" if node.nil?
        return node unless node.respond_to?(:children)
        return node.children.last unless node.respond_to?(:loc) && node.loc.respond_to?(:name)
        name = node.loc.name
        self.content[name.begin_pos, name.end_pos - 1]
      end

    end
  end
end