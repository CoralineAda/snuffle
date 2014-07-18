module Snuffle
  module Formatters

    class HtmlIndex

      include Formatters::Base

      attr_accessor :summaries, :start_path

      def initialize(summaries, start_path)
        self.summaries = summaries.sort{|a,b| a.cohorts.count <=> b.cohorts.count}.reverse
        self.start_path = start_path
      end

      def header
        ["File", "Class", "Object Candidates"].map{|col| "<th>#{col.titleize}</th>"}.join("\r\n")
      end

      def content
        Haml::Engine.new(output_template).render(
          Object.new, {
            summaries: self.summaries,
            start_path: self.start_path,
            date: Time.now.strftime("%Y/%m/%d"),
            time: Time.now.strftime("%l:%M %P")
          }
        )
      end

      def filename
        "index.htm"
      end

      def output_template
        File.read(File.dirname(__FILE__) + "/templates/index.html.haml")
      end

    end

  end
end