Sequel.migration do
  change do
    create_table(:schema_migrations) do
      column :filename, "text", :null=>false
      
      primary_key [:filename]
    end
    
    create_table(:sources) do
      primary_key :id
      column :url, "text", :null=>false
      column :downloaded_at, "timestamp without time zone"
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
      
      index [:url], :name=>:sources_url_key, :unique=>true
    end
    
    create_table(:users) do
      primary_key :id
      column :email, "text", :default=>"", :null=>false
      column :encrypted_password, "text", :default=>"", :null=>false
      column :reset_password_token, "text"
      column :reset_password_sent_at, "text"
      column :remember_created_at, "timestamp without time zone"
      column :sign_in_count, "integer", :default=>0, :null=>false
      column :current_sign_in_at, "timestamp without time zone"
      column :last_sign_in_at, "timestamp without time zone"
      column :current_sign_in_ip, "text"
      column :last_sign_in_ip, "text"
      column :confirmation_token, "text"
      column :confirmed_at, "timestamp without time zone"
      column :confirmation_sent_at, "timestamp without time zone"
      column :unconfirmed_email, "text"
    end
    
    create_table(:downloads) do
      primary_key :id
      foreign_key :source_id, :sources, :null=>false, :key=>[:id]
      column :path, "text"
      column :fetcher, "text", :null=>false
      column :author, "text"
      column :title, "text"
      column :thumbnail_url, "text"
      column :fetcher_information, "jsonb", :null=>false
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
      
      index [:path], :name=>:downloads_path_key, :unique=>true
    end
  end
end
              Sequel.migration do
                change do
                  self << "SET search_path TO \"$user\", public"
                  self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20200412191625_create_first_tables.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20200423145735_remove_title_from_sources.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20200425113118_create_users.rb')"
                end
              end
