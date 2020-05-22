Sequel.migration do
  change do
    alter_table :requests do
      add_foreign_key :feed_id, :feeds
    end
  end
end
