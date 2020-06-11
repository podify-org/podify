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
    elsif new?
      'pending'
    else
      'unknown'
    end
  end

  def queued?
    !!index_of_job_in_queue
  end
  def retrying?
    !!retry_job
  end
  def dead?
    !!index_of_job_in(Sidekiq::DeadSet.new)
  end

  def new?
    created_at >= 10.seconds.ago
  end

  def retry_job
    return @retry_job if defined?(@retry_job)

    retries = Sidekiq::RetrySet.new.to_a
    index = index_of_job_in(retries)
    @retry_job = index && retries[index]
  end

  def downloading?
    progress || Sidekiq::Workers.new.any? do |_, _, work|
      work.dig('payload', 'args', 0) == object.id
    end
  end

  def index_of_job_in_queue
    @index_of_job_in_queue ||= index_of_job_in queue
  end

  def place_in_queue
    return nil unless index_of_job_in_queue

    place = queue.size - index_of_job_in_queue
    "#{place.ordinalize} in queue"
  end

  def retry_status
    return nil unless retrying?

    out = "Retrying"

    if retry_job.item['retry_count']
      out += " (#{retry_job.item['retry_count']} / 25)"
    end

    retry_at = Time.zone.at(retry_job.score)
    if retry_at.past?
      out += " now"
    else
      out += " in " +  helpers.distance_of_time_in_words(Time.now, retry_at)
    end

    # if retry_job.item['error_message']
    #   out += " (#{retry_job.item['error_message']})"
    # end

    out
  end

  def progress
    object.download_progress
  end

  def for_broadcast
    %i[status place_in_queue retry_status].to_h do |attr|
      [attr, send(attr)]
    end
  end

  private

  def index_of_job_in(queue)
    queue.find_index do |job|
      job.args[0] == object.id
    end
  end

  def helpers
    @helpers ||= Class.new do
      extend ActionView::Helpers::DateHelper
    end
  end

  def queue
    @queue ||= Sidekiq::Queue.new('default')
  end
end
