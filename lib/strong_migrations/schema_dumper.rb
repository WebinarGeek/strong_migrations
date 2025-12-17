module StrongMigrations
  module SchemaDumper
    def initialize(connection, ...)
      return super unless StrongMigrations.alphabetize_schema

      super(WrappedConnection.new(connection), ...)
    end
  end

  class WrappedConnection
    delegate_missing_to :@connection

    def initialize(connection)
      @connection = connection
    end

    def columns(...)
      @connection.columns(...).sort_by(&:name)
    end
  end
end
