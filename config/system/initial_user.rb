Dry::Rails.container do
  boot(:initial_user) do |container|
    start do
      Podify::Container['users.create_initial'].call.or do |error|
        raise error.to_s
      end
    end
  end
end
