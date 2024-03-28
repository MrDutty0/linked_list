# frozen_string_literal: true

require_relative 'node'

# Represents the full linked list
class LinkedList
  attr_reader :tail, :size, :head

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def append(to_append)
    new_node = Node.new
    new_node.value = to_append

    @head = new_node if head.nil?

    tail&.point_to_next_node(new_node)
    @tail = new_node

    @size += 1
  end

  def prepend(to_append)
    new_node = Node.new
    new_node.value = to_append

    @tail = new_node if tail.nil?

    new_node.point_to_next_node(head)
    @head = new_node

    @size += 1
  end

  def head_node
    head&.value
  end

  def tail_node
    tail&.value
  end

  def at(index)
    return nil if index >= size || index.negative?

    curr_node = head
    index.times { curr_node = curr_node.next_node }

    curr_node.value
  end

  def pop
    return if size.zero?

    if size == 1
      @head = @tail = nil
    else
      penultimate_node = head
      (size - 2).times { penultimate_node = penultimate_node.next_node }
      penultimate_node.point_to_next_node(nil)
      @tail = penultimate_node
    end

    @size -= 1
  end

  def contains?(value, node = head)
    return false if node.nil?
    return true if node.value == value

    contains?(value, node.next_node)
  end

  def find(value, node = head, idx = 0)
    return nil if node.nil?
    return idx if node.value == value

    find(value, node.next_node, idx + 1)
  end

  def to_s(node = head, string = '')
    return "#{string} nil" if node.nil?

    string += "(#{node.value}) -> "

    to_s(node.next_node, string)
  end

  def insert_at(value, index)
    return nil if index.negative? || index > size

    @size += 1
    node_before = nil
    node_after = head

    index.times do
      node_before = node_after
      node_after = node_after.next_node
    end

    new_node = Node.new(value)
    new_node.point_to_next_node(node_after)

    return @head = new_node if node_before.nil?

    node_before.point_to_next_node(new_node)
    @tail = new_node if node_after.nil?
  end

  def remove_at(index)
    return nil if index.negative? || index >= size

    @size -= 1
    node_before = index.zero? ? nil : head
    node_after = head

    (index - 1).times { node_before = node_before.next_node }
    (index + 1).times { node_after = node_after.next_node }

    return @tail = @head = nil if size.zero?
    return @head = node_after if node_before.nil?

    @tail = node_before if node_after.nil?

    node_before.point_to_next_node(node_after)
  end

  private

  attr_writer :size, :head
end
