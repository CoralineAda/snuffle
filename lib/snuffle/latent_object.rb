module Snuffle

  class LatentObject
    # def suspicious_methods
    #   @suspicious_methods ||=
    #     methods_owned_by_klass.select{ |m| (words_in_method(m.to_s) & potential_objects).size > 0 }
    # end

    DUPLICATE_THRESHOLD = 1

    def self.methods_from(nodes)
      Snuffle::Element::MethodDefinition.materialize(nodes.methods)
    end

    def self.suspicious_methods(nodes, threshold=DUPLICATE_THRESHOLD)
      # results = Snuffle::Util::Histogram::from(arrays)
      # nodes.methods.map(&:name)
      # select{ |m| (words_in_method(m.to_s) & potential_objects).size > 0 }
      names = methods_from(nodes).map(&:method_name)

      words = names.map.inject({}) do |words, method_name|
        name.split('_').each do |word|
          words[word] ||= []
          words[word] << method_name
        end
        words
      end

      method_words = words.keys
      dupes = Snuffle::Util::Histogram::from(method_words)
      dupes.select{|k,v| v > threshold }

    end

    def self.potential_objects
      @potential_objects ||=
        begin
          common_words = find_common_words_in(hash_of_words_used_in_methods)
          words_used_more_than_twice(common_words)
        end
    end

    private

    def words_used_more_than_twice(hash_of_words = {})
      hash_of_words.select{ |k| k.size > 2 }
    end

    def hash_of_words_used_in_methods
      @hash_of_words_used_in_methods ||=
        methods_owned_by_klass.inject({}) do |hash, method|
        hash[method] = words_in_method(method)
        hash
        end
    end

    def find_common_words_in(hash_of_words = hash_of_words_used_in_methods)
      count_word_frequency(hash_of_words).select{ |k,v| v > 1 }.keys
    end

    def count_word_frequency(hash_of_words = {})
      hash_of_words.values.flatten.inject({}) do |hash, word|
        hash[word] ||= 0
        hash[word] += 1
        hash
      end
    end

    def words_in_method(name)
      name.to_s.gsub(/[^a-z\_]/i,'').split('_')
    end
  end

end