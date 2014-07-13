module Snuffle
  module Formatters

    class HtmlIndex

      include Formatters::Base

      attr_accessor :summaries

      def initialize(summaries)
        self.summaries = summaries.sort{|a,b| a.object_candidates.count <=> b.object_candidates.count}.reverse
      end

      def header
        ["File", "Class", "Object Candidates"].map{|col| "<th>#{col.titleize}</th>"}.join("\r\n")
      end

      def content
        Haml::Engine.new(output_template).render(
          Object.new, {
            summaries: summaries,
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