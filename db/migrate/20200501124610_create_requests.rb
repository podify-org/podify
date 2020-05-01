Sequel.migration do
  change do

    create_table :requests do
      primary_key :id
      foreign_key :user_id, :users, null: false
      foreign_key :source_id, :sources, null: false

      DateTime :created_at, null: false
      DateTime :updated_at, null: false

      index [:user_id, :source_id], unique: true
    end

  end
end
