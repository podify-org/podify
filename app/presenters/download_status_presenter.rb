class DownloadStatusPresenter < ApplicationPresenter
  def status
    if downloads.any?
      'downloaded'
    elsif queued?
      'queued'
    elsif retrying?
      'retrying'
    elsif downloading?
      'downloading'
    elsif dead?
      'dead'
    else
      'unknown'
    end
  end

  def queued?
    queue_contains_job? Sidekiq::Queue.new('default')
  end
  def retrying?
    queue_contains_job? Sidekiq::RetrySet.new
  end
  def dead?
    queue_contains_job? Sidekiq::DeadSet.new
  end

  def downloading?
    Sidekiq::Workers.new.any? do |_, _, work|
      work.dig('payload', 'args', 0) == object.id
    end
  end

  def queue_contains_job?(queue)
    queue.any? do |job|
      job.args[0] == object.id
    end
  end
end
