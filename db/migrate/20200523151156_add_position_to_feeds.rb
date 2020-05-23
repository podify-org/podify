Sequel.migration do
  change do
    alter_table :feeds do
      add_column :position, Integer, null: false, default: 9999999
    end
  end
end
