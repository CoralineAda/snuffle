require "spec_helper"

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

  describe "#parent" do
    it "returns a node's parent" do
      allow(child_2).to receive(:id) { 3 }
      expect(Snuffle::Node.by_id(3).first.parent).to eq parent
    end
  end

  describe "#siblings" do

    before do
      allow(parent).to receive(:id)  { 1 }
      allow(child_1).to receive(:id) { 2 }
      allow(child_2).to receive(:id) { 3 }
    end

    it "returns other nodes of a node's type" do
      expect(Snuffle::Node.by_id(3).first.siblings).to eq [parent, child_1]
    end
  end

end
