require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.


#User.all
class SQLObject
  def self.columns
    # ...
    raw_data = DBConnection.instance.execute2(<<-SQL)
      SELECT
        *
      FROM
        '#{self.table_name}'
      LIMIT 1
    SQL

    raw_data.first.map do |element|
      element.to_sym
    end

  end


# Cat.columns ==> :id, :name, :owner_id
  def self.finalize!
    self.columns.each do |column_name|
      define_method "#{column_name}=" do |value|
        attributes[column_name] = value
      end

      define_method "#{column_name}" do
        attributes[column_name]
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    if @table_name.nil?
      self.to_s.tableize
    else
      @table_name
    end
  end

  def self.all

    raw_data = DBConnection.instance.execute(<<-SQL)
      SELECT *
      FROM '#{self.table_name}'
    SQL

    self.parse_all(raw_data)

  end

  def self.parse_all(results)

    objects = []
    results.each do |row|
      objects << self.new(row)
    end

    objects
  end

# def name=(name)
  def self.find(id)
      raw_data = DBConnection.instance.execute(<<-SQL, id)
        SELECT *
        FROM '#{self.table_name}'
        WHERE '#{self.table_name}'.id = ?
        LIMIT 1
      SQL

      if raw_data.empty?
        return nil
      else
        self.new(raw_data.first)
      end
  end

  def initialize(params = {})
    params.each do |key, value|
      if self.class.columns.include?(key.to_sym)
        attributes[key.to_sym] = value
      elsif !self.class.columns.include?(key.to_sym)
        raise "unknown attribute '#{key.to_sym}'"
      end
    end

  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    values = self.class.columns.map do |column_name|
      self.send(column_name)
    end
  end

  def insert
    values = self.attribute_values[1..-1]
    # p values
    col_names = self.class.columns[1..-1].join(",")
    question_marks = (["?"] * (self.class.columns.length - 1)).join(",")
    DBConnection.instance.execute(<<-SQL, *values)
       INSERT INTO
       '#{self.class.table_name}' (#{col_names})
       VALUES
         (#{question_marks})
    SQL
    self.id = DBConnection.instance.last_insert_row_id
  end

  def update
    values = self.attribute_values
    current_id = self.id
    column_names = self.class.columns.join(" = ?, ") + " = ?"
    DBConnection.instance.execute(<<-SQL, *values, current_id)
      UPDATE
        '#{self.class.table_name}'
      SET
        #{column_names}
      WHERE
        id = ?
    SQL
  end

  def save
    if self.id.nil?
      self.insert
    else
      self.update
    end
  end
end
