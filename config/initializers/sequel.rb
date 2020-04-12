DB = Sequel.connect Rails.configuration.database_configuration[Rails.env]

Sequel.extension(:pg_json_ops)

DB.extension :pg_json
DB.extension :pg_enum
