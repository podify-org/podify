Sequel.migration do
  change do

    create_table :sources do
      primary_key :id

      String :url, null: false, unique: true
      String :title
      DateTime :downloaded_at

      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end

    create_table :downloads do
      primary_key :id

      foreign_key :source_id, :sources, null: false
      String :path, null: true, unique: true

      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end

  end
end
