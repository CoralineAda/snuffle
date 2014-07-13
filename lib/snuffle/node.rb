module Snuffle

  class Node

    include Ephemeral::Base
    include PoroPlus

    attr_accessor :id, :name, :type, :child_ids, :parent_id

    scope :by_id,   lambda{|id| where(:id => id)}
    scope :by_type, lambda{|type| where(:type => type) }
    scope :hashes, {type: :hash}

    def self.nil
      new(type: :nil)
    end

    def initialize(*args, &block)
      @id = id
      super
    end

    def id
      @id ||= SecureRandom.uuid
    end

    # def name
    #   @name.size > 20 ? "#{@name[0..20]}..." : @name
    # end

    def parent
      Snuffle::Node.where(id: self.parent_id).first
    end

    def children
      Snuffle::Node.where(parent_id: self.id)
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