require 'thor'
require 'snuffle'

module Snuffle

  class CLI < Thor

    desc "snuffle check PATH_TO_FILES", "Example: snuffle app/models/"
    def check(path="./")
      summaries = []
      file_list(path).each do |path_to_file|
        puts "Checking #{path_to_file}..."
        Snuffle::Node.delete_all
        summary = Snuffle::SourceFile.new(path_to_file: path_to_file).summary
        html_report(summary, summary.source)
        summaries << summary
      end
      create_html_index(summaries, path)
      puts "Results written to #{results_files.last}"
    end

    default_task :check

    attr_accessor :last_file

    private

    def file_list(start_file)
      if File.directory?(start_file)
        return Dir.glob(File.join(start_file, "**", "*")).select{|n| n =~ /\.rb$/}
      else
        return [start_file]
      end
    end

    def report(summary, source)
      text_report(summary)
      cvs_report(summary)
    end

    def create_html_index(summaries, start_path)
      results_files << Snuffle::Formatters::HtmlIndex.new(summaries, start_path).export
    end

    def html_report(summary, source)
      return unless summary.cohorts.count > 0 || summary.latent_objects.count > 0
      results_files << Snuffle::Formatters::Html.new(summary, source).export
    end

    def results_files
      @results_files ||= []
    end

  end

end
