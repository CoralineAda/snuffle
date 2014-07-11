# d.nodes.where(type: :sym).select{|n| n.grandparent.type == :hash}.group_by{|n| n.grandparent.id}.values.map{|set| set.map(&:name)}



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

  def parent
    Node.where(id: self.parent_id).first
  end

  def descendents(nodes=[])
    nodes << self.children.map{|desc| descendents(desc, nodes)}
    nodes.flatten
  end

  def siblings
    Node.where(parent_id: self.parent_id)
  end

  def children
    Node.where(parent_id: self.id)
  end

end
