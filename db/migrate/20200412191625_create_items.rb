Sequel.migration do
  change do

    create_table :items do
      primary_key :id
      String :path, null: false, unique: true
      String :title, null: false

      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end

  end
end
