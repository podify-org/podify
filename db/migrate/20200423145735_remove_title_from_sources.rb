Sequel.migration do
  up do
    alter_table :sources do
      drop_column :title
    end
  end

  down do
    alter_table :sources do
      add_column :title, String
    end
  end
end
