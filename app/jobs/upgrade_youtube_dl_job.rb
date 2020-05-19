class UpgradeYoutubeDlJob
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform
    `pip3 install --upgrade youtube-dl`
  end
end
