require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super("questions.db")
    self.results_as_hash = true
    self.type_translation = true
  end

  def self.save(table_name, id, c_names, c_values)
    c_names.map! { |name| name.to_s[1..-1] }
    name_string = "(#{c_names[1..-1].join(', ')})"
    value_string = "("
    (c_names.size-2).times { value_string << "?, " }
    value_string += " ?)"

    col_string = c_names.drop(1).join(' = ?, ') + ' = ?'

    if id.nil?
      self.instance.execute(<<-SQL, *c_values[0..-2])
        INSERT INTO
          #{table_name} #{name_string}
        VALUES
          #{value_string}
      SQL
      self.instance.last_insert_row_id
    else
      self.instance.execute(<<-SQL, *c_values)
        UPDATE
          #{table_name}
        SET
          #{col_string}
        WHERE
          id = ?
      SQL

      id
    end
  end
end
