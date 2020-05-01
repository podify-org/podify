Sequel.migration do
  change do
    alter_table :users do
      add_column :authentication_token, :text, unique: true
      add_column :authentication_token_created_at, DateTime
    end
  end
end
