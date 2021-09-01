psql -U postgres -c "CREATE USER podify;"

createdb -U postgres -O podify podify_development
createdb -U postgres -O podify podify_test
