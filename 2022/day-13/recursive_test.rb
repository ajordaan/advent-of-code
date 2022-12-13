def compare(left, right)
  # If both values are integers, compare the integers
  if left.is_a?(Integer) && right.is_a?(Integer)
    if left < right
      return true # left integer is lower, so inputs are in the right order
    elsif left > right
      return false # left integer is higher, so inputs are not in the right order
    else
      return compare(left[1..-1], right[1..-1]) # both integers are the same, so continue checking the next part of the input
    end
  end

  # If both values are lists, compare the first values of each list
  if left.is_a?(Array) && right.is_a?(Array)
    if left.length < right.length
      return true # left list is shorter, so inputs are in the right order
    elsif left.length > right.length
      return false # right list is shorter, so inputs are not in the right order
    else
      if compare(left[0], right[0])
        return compare(left[1..-1], right[1..-1]) # left value is lower, so continue checking the next part of the input
      else
        return false # left value is higher or the same, so inputs are not in the right order
      end
    end
  end

  # If exactly one value is an integer, convert the integer to a list and retry the comparison
  if left.is_a?(Integer)
    left = [left]
  elsif right.is_a?(Integer)
    right = [right]
  end
  compare(left, right)
end


compare([1,1,3,1,1], [1,1,5,1,1])
