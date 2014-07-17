# TODO factor out poroplus here

require "parser/current"

module Snuffle

  class SourceFile

    include PoroPlus

    attr_accessor :path_to_file, :source, :lines_of_code

    def class_name
      return @class_name if @class_name
      @class_name = find_class(ast) || "?"
    end

    def nodes
      @nodes ||= extract_nodes_from(ast)
    end

    def cohorts
      @cohorts ||= Cohort.from(self.nodes)
    end

    def source
      return @source if @source
      end_pos = 0
      self.lines_of_code = []
      @source = File.readlines(self.path_to_file).each_with_index do |line, index|
        start_pos = end_pos + 1
        end_pos += line.size
        self.lines_of_code << LineOfCode.new(line_number: index + 1, range: (start_pos..end_pos))
        line
      end.join
    end

    def summary
      Summary.new(
        source_file: self,
        source: self.source,
        class_name: class_name,
        path_to_file: self.path_to_file,
        cohorts: cohorts,
        source: self.source
      )
    end

    private

    def text_at(start_pos, end_pos)
      source[start_pos..end_pos - 1]
    end

    def find_class(node)
      return unless node.respond_to?(:type)
      concat = []
      if node.type == :module || node.type == :class
        concat << text_at(node.loc.name.begin_pos, node.loc.name.end_pos)
      end
      unless node.type == :class
        concat << node.children.map{|child| find_class(child)}.compact
      end
      concat.flatten.select(&:present?).join('::')
    end

    def ast
      @ast ||= Parser::CurrentRuby.parse(source)
    end

    def extract_nodes_from(ast_node, nodes=Ephemeral::Collection.new("Snuffle::Node"), parent_id=:root)
      if name = name_from(ast_node)
        if ast_node.respond_to?(:type)
          lines = LineOfCode.containing(lines_of_code, ast_node.loc.expression.begin_pos, ast_node.loc.expression.end_pos)
          extracted_node = Snuffle::Node.new(
            type: ast_node.type,
            parent_id: parent_id,
            name: name_from(ast_node),
            line_numbers: lines.map(&:line_number)
          )
        else
          extracted_node = Snuffle::Node.new(
            type: :nil,
            parent_id: parent_id,
            name: name
          )
        end
        nodes << extracted_node
        ast_node.children.each{|child| extract_nodes_from(child, nodes, extracted_node.id)} if ast_node.respond_to?(:children)
      end
      nodes
    end

    def name_from(node)
      return if node.nil?
      return node unless node.respond_to?(:children)
      if node.respond_to?(:loc) && node.loc.respond_to?(:name)
        name_coords = node.loc.name
        name = source[name_coords.begin_pos, name_coords.end_pos - 1]
        return unless name =~ /[a-zA-Z]/
        return name
      else
        return name_from(node.children.last)
      end
    end

  end

end