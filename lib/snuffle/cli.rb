require 'thor'
require 'snuffle'

module Snuffle

  class CLI < Thor

    desc_text = "Formats are text (default, to STDOUT), html, and csv. "
    desc_text << "Example: snuffle check foo/ -f html"

    desc "check PATH_TO_FILE [-f FORMAT] [-t MAX_COMPLEXITY_ALLOWED]", desc_text
    method_option :format, :type => :string, :default => 'text', :aliases => "-f"

    def check(path="./")
      summaries = file_list(path).map do |path_to_file|
        Snuffle::SourceFile.new(path_to_file: path_to_file).summary
      end
      summaries.each{|summary| report(summary)}
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

    def report
      text_report
      cvs_report
      html_report
    end

    def cvs_report(summary)
      return unless options['format'] == 'csv'
      results_files << ::Formatters::Csv.new(summary).export
    end

    def html_report(file_summary)
      return unless options['format'] == 'html'
      index = ::Formatters::HtmlIndex.new(file_summary)
      self.last_file = "#{index.output_path}/#{index.filename}"
      index.export
    end

    def text_report
      return unless options['format'] == 'text'
      file = SourceFile.new(path_to_file: path_to_file)
      puts ::Formatters::Text.new(file).export
    end

    def results_files
      @results_files ||= []
    end

  end

end
