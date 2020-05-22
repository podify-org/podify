Sequel.migration do
  up do
    alter_table :downloads do
      drop_column :path
    end
  end

  down do
    alter_table :downloads do
      add_column :path, String, null: true, unique: true
    end
  end
end
