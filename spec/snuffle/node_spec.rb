require "spec_helper"

Snuffle::Node.class_variable_set(:@@objects, [])

describe Snuffle::Node do

  let(:source)  { Snuffle::SourceFile.new }
  let(:parent)  { Snuffle::Node.new(id: 1, parent_id: :root, type: :hash) }
  let(:child_1) { Snuffle::Node.new(id: 2, parent_id: 1, type: :hash) }
  let(:child_2) { Snuffle::Node.new(id: 3, parent_id: 1, type: :hash) }

  describe ".nil" do
    it "returns a default object" do
      expect(Snuffle::Node.nil.type).to eq(:nil)
    end
  end

end
