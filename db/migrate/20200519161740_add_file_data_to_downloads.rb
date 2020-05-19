Sequel.migration do
  change do
    add_column :downloads, :file_data, :jsonb
  end
end
