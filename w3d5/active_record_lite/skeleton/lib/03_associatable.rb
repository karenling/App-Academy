require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    self.class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})

    if !options.has_key?(:foreign_key)
      @foreign_key = "#{name}_id".to_sym
    else
      @foreign_key = options[:foreign_key]
    end

    if !options.has_key?(:primary_key)
      @primary_key = "id".to_sym
    else
      @primary_key = options[:primary_key]
    end

    if !options.has_key?(:class_name)
      @class_name = name.capitalize.singularize
    else
      @class_name = options[:class_name]
    end

  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    #
    # p ["name", "self_class_name", "options"]
    # p [name, self_class_name, options]

    if !options.has_key?(:class_name)
      @class_name = name.capitalize.singularize
    else
      @class_name = options[:class_name]
    end

    if !options.has_key?(:foreign_key)
      @foreign_key = "#{self_class_name.to_s.downcase}_id".to_sym
    else
      @foreign_key = options[:foreign_key]
    end

    if !options.has_key?(:primary_key)
      @primary_key = "id".to_sym
    else
      @primary_key = options[:primary_key]
    end

  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})

    options = BelongsToOptions.new(name.to_s, options) #owner
    assoc_options[name] = options

    # name is human
    # p options
    # p options.model_class is Human
    # p self is a cat
    define_method "#{name}" do # house
      foreign_key = self.send(options.foreign_key)
      # options.model_class
      # anytime the key is not a symbol, we have to rocket
      options.model_class.where(options.primary_key => foreign_key).first
    end
  end

  def has_many(name, options = {})
    # self is human
    # name is cats
    # options has foreign_key => owner_id
    # # primary key is id
    # p self
    # p name
    # p options
    #
    #
    # human has many cats
    # the foreign key is on
    options = HasManyOptions.new(name.to_s, self, options)

    define_method "#{name}" do
      primary_key = self.send(options.primary_key) #getting the human's PK
      # p options.model_class# is cat

      options.model_class.where(options.foreign_key => primary_key)
      #the cat's foreign key (:owner_id) maps to the human's id
      # p options.model_class.where(options.primary_key => foreign_key)

      # p options
      # p self
      # p self.foreign_key
      # p foreign_key = name.send(options.foreign_key)
      # foreign_key = options.foreign_key
      # options.model_class.where(options.primary_key => foreign_key)
    end
    #
    # define_method "#{name}" do
    # end
  end

  def assoc_options
    @assoc_options ||= {}
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  # Mixin Associatable here...
  extend Associatable
end
