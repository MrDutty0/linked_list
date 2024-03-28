# frozen_string_literal: true

# Represents a node of a linked list
class Node
  attr_accessor :value
  attr_reader :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end

  def point_to_next_node(second_node = nil)
    @next_node = second_node
  end

  private

  attr_writer :next_node
end
