require 'spec_helper'
require 'pry'

describe Snuffle::SourceFile do

  let(:program_2) { Snuffle::SourceFile.new(path_to_file: "spec/fixtures/program_2.rb") }
  let(:program_3) { Snuffle::SourceFile.new(path_to_file: "spec/fixtures/program_3.rb") }
  let(:program_4) { Snuffle::SourceFile.new(path_to_file: "spec/fixtures/program_4.rb") }

  describe "#cohorts" do

    it "does not match hash values with non-hash values" do
      attr_accessor_args = ['city', 'postal_code', 'state']
      values = program_2.summary.cohorts.map(&:values)
      expect(values.include?(attr_accessor_args)).to be_falsey
    end

    it "matches elements with the same type" do
      args = ['company_name', 'customer_name']
      values = program_3.summary.cohorts.map(&:values)
      expect(values.include?(args)).to be_truthy
    end

    xit "does not match loose class method calls" do
      values = program_4.summary.cohorts.map(&:values)
      expect(values.empty?).to be_truthy
    end

  end

  describe "#name_from" do

    let(:program) { Snuffle::SourceFile.new(path_to_file: "spec/fixtures/latent_object_fixture.rb") }
    let(:node)    { program.send(:ast).children[2].children[1] }

    it "pulls the name of a method" do
      expect(program.send(:name_from, node)).to eq('initialize')
    end

  end

  describe "#class_name" do

    let(:top_level)    { "require 'something'; class Foo; def bar; puts 'hi'; end; end"}
    let(:namespaced_1) { "require 'something'; class Foo::Bar; def bar; puts 'hi'; end; end"}
    let(:namespaced_2) { "require 'something'; module Foo; module Bar; class Baz; def bar; puts 'hi'; end; end; end; end"}
    let(:namespaced_3) { "class Foo; module Bar; class Baz; class << self; end; end; end; end" }
    let(:source_file)  { Snuffle::SourceFile.new }

    it "picks up a non-nested class name" do
      source_file.source = top_level
      expect(source_file.class_name).to eq("Foo")
    end

    it "picks up a namespaced class name" do
      source_file.source = namespaced_1
      expect(source_file.class_name).to eq("Foo::Bar")
    end

    it "picks up a class name inside nested modules" do
      source_file.source = namespaced_2
      expect(source_file.class_name).to eq("Foo::Bar::Baz")
    end

    xit "picks up crazily nested names" do
      source_file.source = namespaced_3
      expect(source_file.class_name).to eq("Foo::Bar::Baz")
    end

  end

end