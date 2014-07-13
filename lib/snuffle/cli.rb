require 'thor'
require 'snuffle'

module Snuffle

  class CLI < Thor

    desc_text = "Formats are text (default, to STDOUT), html, and csv. "
    desc_text << "Example: snuffle check foo/ -f html"

    desc "check PATH_TO_FILE [-f FORMAT] [-t MAX_COMPLEXITY_ALLOWED]", desc_text
    method_option :format, :type => :string, :default => 'text', :aliases => "-f"
    method_option :threshold, :type => :numeric, :default => 0, :aliases => "-t"

    def check(path="./")
      file_list(path).each{ |path_to_file| parse(path_to_file) }
      handle_index(summaries)
      report
    end

    default_task :check

    attr_accessor :summaries, :last_file

    private

    def file_list(start_file)
      if File.directory?(start_file)
        return Dir.glob(File.join(start_file, "**", "*")).select{|n| n =~ /\.rb$/}
      else
        return [start_file]
      end
    end

    def formatter
      case options['format']
      when 'html'
        Formatters::Html
      when 'csv'
        Formatters::Csv
      else
        Formatters::Text
      end
    end

    def handle_index(file_summary)
      return unless options['format'] == 'html'
      index = Formatters::HtmlIndex.new(file_summary)
      self.last_file = "#{index.output_path}/#{index.filename}"
      index.export
    end

    def parse(path_to_file, options={})
      file = ParsedFile.new(path_to_file: path_to_file)
      self.summaries ||= []
      self.summaries << file.summary.merge(results_file: parser.path_to_results)
      last_file = file
    end

    def report
      unless options['format'] == "text"
        puts "Results written to:"
        puts last_file.present? && "#{last_file}" || results_files.join("\r\n")
      end
      report_complexity
    end

    def results_files
      summaries.map{|s| s[:results_file]}
    end

  end

end
