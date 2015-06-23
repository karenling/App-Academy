class MyHashSet

  def initialize(options = {})
    @store = options
  end


  def store #reader
    @store
  end

  def insert(el)
    store[el] = true
  end

  def include?(el)
    store.has_key?(el)
  end

  def delete(el)
    if include?(el)
      store.delete(el)
      true
    else
      false
    end
  end

  def to_a
    store.keys
  end

  def union(set2)
    unionized_hash = set2

    store.each do |k,v|
      unionized_hash.insert k
    end

    MyHashSet.new(unionized_hash)
  end

  def intersect(set2)
    intersection = MyHashSet.new

    store.each do |key, value|
      if set2.include?(key)
        intersection.insert(key)
      end
    end

    return intersection
  end

  def minus(set2)
    only_set1 = MyHashSet.new
    only_set1 = store

    store.each do |k, v|
      only_set1.delete(k) if set2.include?(k)
    end

    MyHashSet.new(only_set1)
  end

end

set1 = MyHashSet.new
set1.insert(1)
set1.insert(2)
set1.insert(3)

set2 = MyHashSet.new
set2.insert(3)
set2.insert(4)
set2.insert(5)

# unionized_set = set1.union(set2)
# p unionized_set.to_a

# # p set1.union(set2)
# p set1.intersect(set2)
p set1.minus(set2)
