require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)

    where_line = params.keys.join(" = ? AND ") + " = ?"
    values = params.values
    results = DBConnection.instance.execute(<<-SQL, *values)
      SELECT *
      FROM '#{self.table_name}'
      WHERE #{where_line}
    SQL

    parse_all(results)
  end
end

class SQLObject
  # Mixin Searchable here...
  extend Searchable
end
