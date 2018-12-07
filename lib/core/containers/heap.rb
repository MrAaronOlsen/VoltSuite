class Heap

  def initialize(comparator = lambda { |x, y| x >= y })
    @nodes = [nil]
    @comparator = comparator
  end

  def set_comparator(&block)
    @comparator = block
  end

  def add(element)
    @nodes.push(element)
    bubble_up(@nodes.size - 1)
  end

  def add_many(elements)
    elements.each { |e| add(e) }
  end

  def pop
    exchange(1, @nodes.size - 1)
    max = @nodes.pop

    bubble_down(1)
    max
  end

  def pop_many(number)
    [].tap do |results|
      number.times do
        results << pop
      end
    end
  end

  def peek
    @nodes[1]
  end

  private

  def bubble_up(index)
    parent_index = index / 2

    return if index <= 1
    return if @comparator.call(@nodes[parent_index], @nodes[index])

    exchange(index, parent_index)

    bubble_up(parent_index)
  end

  def bubble_down(index)
    child_index = (index * 2)

    return if child_index > @nodes.size - 1

    not_the_last_element = child_index < @nodes.size - 1
    child_index += 1 if not_the_last_element && @comparator.call(@nodes[child_index + 1], @nodes[child_index])

    return if @comparator.call(@nodes[index], @nodes[child_index])

    exchange(index, child_index)

    bubble_down(child_index)
  end

  def exchange(source, target)
    @nodes[source], @nodes[target] = @nodes[target], @nodes[source]
  end
end