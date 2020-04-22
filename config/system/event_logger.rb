Dry::Rails.container do
  boot(:event_logger) do
    start do
      Podify::Container['events.logger'].subscribe
    end
  end
end
