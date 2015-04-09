require 'uea-stemmer'

class Snuffle::LatentObject

  include PoroPlus

  attr_accessor :object_candidate, :source_methods

  DUPLICATE_THRESHOLD = 1
  STOPWORDS = [
    "the", "be", "to", "of", "and", "a", "in", "that", "have", "I", "it", "for",
    "not", "on", "with", "he", "as", "you", "do", "at", "this", "but", "his",
    "by", "from", "they", "we", "say", "her", "she", "or", "an", "will", "my", "are",
    "one", "all", "would", "there", "their", "what", "so", "up", "out", "if", "is",
    "about", "who", "get", "which", "go", "me", "when", "make", "can", "like",
    "time", "no", "just", "him", "know", "take", "into", "else", "other", "again",
    "your", "good", "some", "could", "them", "see", "other", "than", "then",
    "now", "look", "only", "come", "its", "over", "think", "also", "back", "else",
    "after", "use", "two", "how", "our", "work", "first", "well", "way", "even",
    "new", "want", "because", "any", "these", "give", "day", "most", "us", "call",
    "create", "edit", "new", "delete", "destroy", "update"
  ]

  def self.from(nodes)
    potential_objects_with_methods(nodes).map do |k,v|
      new(object_candidate: k, source_methods: v)
    end
  end

  def self.potential_objects_with_methods(nodes, threshold=DUPLICATE_THRESHOLD)
    method_candidates = Snuffle::Element::MethodDefinition.materialize(nodes.method_defs)
    extract_candidates(method_candidates).select{|k,v| v.count > threshold }
  end

  def self.extract_candidates(method_defs)
    stemmer = UEAStemmer.new
    method_defs.map(&:method_name).inject({}) do |words, method_name|
      atoms = method_name.split('_') - STOPWORDS
      atoms = atoms.map{|atom| stemmer.stem(atom.to_s)}
      atoms.each{ |word| words[word] ||= []; words[word] << method_name }
      words
    end
  end

end

