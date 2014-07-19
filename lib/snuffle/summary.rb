module Snuffle

  class Summary
    include PoroPlus
    attr_accessor :class_name, :path_to_file, :cohorts, :latent_objects, :source

   def has_results?
      self.cohorts.count != 0 || self.latent_objects.count != 0
    end

    def path_to_results
      self.path_to_file.split("/")[0..-2].join('/')
    end

    def filename
      path_to_file.split("/")[-1]
    end

  end

end