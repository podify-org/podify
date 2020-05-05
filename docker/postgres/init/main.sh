psql -U postgres -c "CREATE USER podify WITH PASSWORD 'FJJuo5onaohF8rp';"

createdb -U postgres -O podify podify_development
createdb -U postgres -O podify podify_test
