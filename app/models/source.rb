class Source < ApplicationModel
  one_to_many :requests
  many_to_many :users, join_table: :requests

  one_to_many :downloads
  # add_association_dependencies downloads: :destroy

  dataset_module do
    def by_file_path(path)
      by_url("file://#{path.to_s}")
    end

    def by_url(url)
      where(url: url)
    end

    def without_requests
      exclude(id: Request.distinct.select(:source_id))
    end
  end

  def download_progress
    redis.get(download_progress_redis_key)&.to_f
  end

  def download_progress=(progress)
    redis.set(download_progress_redis_key, progress, ex: 10)
  end

  private

  def download_progress_redis_key
    raise "Can only get or set download_progress for persisted sources" unless id

    "source:#{id}:download_progress"
  end

  def redis
    Podify::Container['redis']
  end
end
