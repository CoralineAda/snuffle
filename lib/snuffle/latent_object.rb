class Snuffle::LatentObject

  include PoroPlus

  attr_accessor :object_candidate, :source_methods

  DUPLICATE_THRESHOLD = 1

  def self.from(nodes)
    potential_objects_with_methods(nodes).map do |k,v|
      new(object_candidate: k, source_methods: v)
    end
  end

  def self.potential_objects_with_methods(nodes, threshold=DUPLICATE_THRESHOLD)
    method_candidates = Snuffle::Element::MethodDefinition.materialize(nodes.methods)
    extract_candidates(method_candidates).select{|k,v| v.count > threshold }
  end

  def self.extract_candidates(methods)
    methods.map(&:method_name).inject({}) do |words, method_name|
      atoms = method_name.split('_')
      atoms.each{ |word| words[word] ||= []; words[word] << method_name }
      words
    end
  end

end

