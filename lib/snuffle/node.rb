class Node

  include Ephemeral::Base
  include PoroPlus

  attr_accessor :id, :name, :type, :children, :parent

  def id
    @id ||= SecureRandom.uuid
  end

end

