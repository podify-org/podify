Sequel.migration do
  change do

    create_table :feeds do
      primary_key :id

      foreign_key :user_id, :users, null: false
      String :type, null: false, default: 'all'
      String :name, null: false
      String :token, null: false, unique: true

      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end

  end
end
