psql -U postgres -c "CREATE USER podify WITH PASSWORD 'FJJuo5onaohF8rp';"

createdb -U postgres -O podify podify_development
createdb -U postgres -O podify podify_test

# psql -U postgres -c "CREATE USER podify_password WITH PASSWORD 'J8QKMaG3ar7z5Qz';"
# psql -U postgres -c "DROP SCHEMA public CASCADE;" podify
# psql -U postgres -c "CREATE SCHEMA podify AUTHORIZATION podify;" podify
# psql -U postgres -c "CREATE SCHEMA podify_password AUTHORIZATION podify_password;" podify
# psql -U postgres -c "GRANT USAGE ON SCHEMA podify TO podify_password;" podify
# psql -U postgres -c "GRANT USAGE ON SCHEMA podify_password TO podify;" podify
# psql -U postgres -c "CREATE EXTENSION citext SCHEMA podify" podify
