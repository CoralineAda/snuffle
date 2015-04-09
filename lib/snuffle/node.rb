module Snuffle

  class Node

    include Ephemeral::Base
    include PoroPlus

    attr_accessor :id, :name, :type, :child_ids, :parent_id, :line_numbers, :args

    scope :by_id,       lambda{|id| where(:id => id)}
    scope :by_type,     lambda{|type| where(:type => type)}
    scope :with_parent, lambda{|parent_id| where(parent_id: parent_id) }
    scope :hashes,      {type: :hash}
    scope :methods,     {is_method: true}
    scope :non_sends,   {is_send: false}

    def self.nil
      new(type: :nil)
    end

    def self.not_a(type)
      select{|node| node.type != type}
    end

    def initialize(*args, &block)
      @id = SecureRandom.uuid
      super
    end

    def parent
      Snuffle::Node.where(id: self.parent_id).first
    end

    def siblings
      @siblings ||= Snuffle::Node.by_type(self.type).to_a - [self]
    end

    def children
      Snuffle::Node.where(parent_id: self.id)
    end

    def is_method
      self.type == :def || self.type == :defs
    end

    def is_send
      self.type == :send
    end

    def inspect
      {
        id: self.id,
        type: self.type,
        parent_id: self.parent_id,
        child_ids: self.child_ids
      }.to_s
    end

  end
end