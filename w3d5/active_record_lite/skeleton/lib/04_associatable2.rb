require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options
  #Cat through home human house
  def has_one_through(name, through_name, source_name)
    # p "name: #{name}"
    # p "through_name: #{through_name}"
    # p "source_name: #{source_name}"
    # p "self: #{self}"

    # p Cat.assoc_options[through_name]
    # p "WHERE"
    through_options = self.assoc_options[through_name]

    define_method "#{name}" do
      # p through_options # @foreign_key=:owner_id, @primary_key=:id, @class_name="Human"
      # # through_options.model_class #human
      # # p through_options.model_class
      # p "our through options"
      # p through_options.table_name #humans
      # p through_options.table_name.foreign_key #humans_id

      foreign_key = self.owner_id
      source_options = through_options.model_class.assoc_options[source_name] #@foreign_key=:house_id, @primary_key=:id, @class_name="House"
      # p "hereee!"
      # p source_options.foreign_key #house_id
      # p "ours source options"
      # p source_options.table_name #houses
      # p source_options.table_name.foreign_key #house_id
      # p self
      # p "hello"
      #
      # p self.class.table_name
      # p self.owner_id
      #
      # p through_options
      #
      # p source_options
      # p through_options
      # p self.id

      #{through_options.table_name.foreign_key}

      # house_id = source_options
      raw_data = DBConnection.instance.execute(<<-SQL, self.id)

        SELECT *
        FROM #{source_options.table_name}
        WHERE #{source_options.table_name}.id = (
          SELECT #{through_options.table_name}.#{source_options.foreign_key}
          FROM #{through_options.table_name}
          INNER JOIN #{self.class.table_name} ON #{through_options.table_name}.id = ? )
          


        -- --
        -- SELECT *
        -- FROM houses
        -- WHERE houses.id = (
        --   SELECT humans.house_id
        --   FROM humans
        --   INNER JOIN cats ON humans.id = cats.owner_id
        --
        --
        --
        --   SELECT *
        --   FROM houses
        --   WHERE houses.id = (
        --     SELECT humans.house_id
        --     FROM humans
        --     INNER JOIN cats ON humans.id = cats.owner_id)

      SQL
      #
      # p "is this working?"
      # p raw_data
      # p House.new(raw_data.first)
      house = source_options.class_name.constantize #House
      p house.new(raw_data.first)
    end
  end
end

#
# options = HasManyOptions.new(name.to_s, self, options)
#
# define_method "#{name}" do
#   primary_key = self.send(options.primary_key) #getting the human's PK
#
#   options.model_class.where(options.foreign_key => primary_key)
